import Html
import XCTest

final class AttributesTests: XCTestCase {
  func testAttributes() {
    XCTAssertEqual(
      """
      <th abbr="blob" colspan="1" headers="blob" rowspan="1" scope></th>
      """,
      render(.th(attributes: [.abbr("blob"), .colspan(1), .headers("blob"), .rowspan(1), .scope(.auto)]))
    )
    XCTAssertEqual("<th scope=\"col\"></th>", render(.th(attributes: [.scope(.col)])))
    XCTAssertEqual("<th scope=\"colgroup\"></th>", render(.th(attributes: [.scope(.colgroup)])))
    XCTAssertEqual("<th scope=\"row\"></th>", render(.th(attributes: [.scope(.row)])))
    XCTAssertEqual("<th scope=\"rowgroup\"></th>", render(.th(attributes: [.scope(.rowgroup)])))

    XCTAssertEqual(
      "<a href=\"/user/foo&quot; onmouseover=&quot;alert(1)\">XSS</a>",
      render(.a(attributes: [.href("/user/foo\" onmouseover=\"alert(1)")], "XSS"))
    )

    XCTAssertEqual("<a accesskey=\"a\"></a>", render(.a(attributes: [.accesskey("a")])))

    XCTAssertEqual(
      """
      <form action="/" name="blob" novalidate></form>
      """,
      render(.form(attributes: [.action("/"), .method(.get), .name("blob"), .novalidate(true)]))
    )
    XCTAssertEqual(
      """
      <form action="/" method="post"></form>
      """,
      render(.form(attributes: [.action("/"), .method(.post), .novalidate(false)]))
    )
    XCTAssertEqual("<area alt=\"blob\">", render(.area(attributes: [.alt("blob")])))

    XCTAssertEqual(
      """
      <img alt="blob" crossorigin height="42" src="src" width="43">
      """,
      render(.img(attributes: [.alt("blob"), .crossorigin(.anonymous), .height(42), .src("src"), .width(43)]))
    )
    XCTAssertEqual(
      """
      <img crossorigin="use-credentials">
      """,
      render(.img(attributes: [.crossorigin(.useCredentials)]))
    )
    XCTAssertEqual(
      """
      <img src="src1" srcset="src3 3x, src2 2x, src1 1x" height="42" width="43">
      """,
      render(.img(attributes: [.src("src1"), .srcset(["src3": .x(3), "src2": .x(2), "src1": .x(1)]), .height(42), .width(43)]))
    )
    XCTAssertEqual(
      """
      <img src="src1" srcset="src2 84w, src1 42w, src3 126w" height="42" width="43">
      """,
      render(.img(attributes: [.src("src1"), .srcset(["src1": .w(42), "src2": .w(84), "src3": .w(126)]), .height(42), .width(43)]))
    )

    XCTAssertEqual(
      """
      <input\
       alt="blob"\
       autofocus\
       checked\
       disabled\
       form="form"\
       height="42"\
       max="10.0"\
       max="11"\
       maxlength="12"\
       min="13.0"\
       min="14"\
       minlength="15"\
       multiple\
       name="blob name"\
       pattern=".+"\
       placeholder="..."\
       readonly\
       required\
       src="src"\
       step="2"\
       width="43"\
      >
      """,
      render(
        .input(
          attributes: [
            .alt("blob"),
            .autofocus(true),
            .checked(true),
            .disabled(true),
            .form("form"),
            .height(42),
            .max(10 as Double),
            .max(11 as Int),
            .maxlength(12),
            .min(13 as Double),
            .min(14 as Int),
            .minlength(15),
            .multiple(true),
            .name("blob name"),
            .pattern(".+"),
            .placeholder("..."),
            .readonly(true),
            .required(true),
            .src("src"),
            .step(2),
            .width(43)
          ]
        )
      )
    )
    XCTAssertEqual(
      """
      <input>
      """,
      render(.input(attributes: [.autofocus(false), .checked(false), .disabled(false), .readonly(false), .required(false)]))
    )

    XCTAssertEqual(
      """
      <script async charset="utf-8" defer nonce="blob" src="blob.js"></script>
      """,
      render(.script(attributes: [.async(true), .charset(.utf8), .defer(true), .nonce("blob"), .src("blob.js")]))
    )
    XCTAssertEqual(
      """
      <script></script>
      """,
      render(.script(attributes: [.async(false), .defer(false)]))
    )

    XCTAssertEqual(
      """
      <button autofocus disabled form="form" name="blob"></button>
      """,
      render(.button(attributes: [.autofocus(true), .disabled(true), .form("form"), .name("blob")]))
    )
    XCTAssertEqual(
      """
      <button></button>
      """,
      render(.button(attributes: [.autofocus(false), .disabled(false)]))
    )

    XCTAssertEqual(
      """
      <select autofocus disabled form="form" name="blob" required><option selected>blob</option></select>
      """,
      render(
        .select(
          attributes: [.autofocus(true), .disabled(true), .form("form"), .name("blob"), .required(true)],
          .option(attributes: [.selected(true)], "blob")
        )
      )
    )
    XCTAssertEqual(
      """
      <select><option>blob</option></select>
      """,
      render(
        .select(
          attributes: [.autofocus(false), .disabled(false), .required(false)],
          .option(attributes: [.selected(false)], "blob")
        )
      )
    )

    XCTAssertEqual(
      """
      <textarea autofocus cols="80" disabled form="form" name="blob" placeholder="..." readonly required rows="24" wrap="hard"></textarea>
      """,
      render(
        .textarea(
          attributes: [
            .autofocus(true),
            .cols(80),
            .disabled(true),
            .form("form"),
            .name("blob"),
            .placeholder("..."),
            .readonly(true),
            .required(true),
            .rows(24),
            .wrap(.hard)
          ]
        )
      )
    )
    XCTAssertEqual(
      """
      <textarea wrap="soft"></textarea>
      """,
      render(
        .textarea(
          attributes: [
            .autofocus(false),
            .disabled(false),
            .readonly(false),
            .required(false),
            .wrap(.soft)
          ]
        )
      )
    )

    XCTAssertEqual(
      """
      <audio autoplay controls loop muted preload src="src">\
      <track src="captions" default kind="captions" label="blob" srclang="en">\
      <track src="chapters" kind="chapters">\
      <track src="descriptions" kind="descriptions">\
      <track src="metadata" kind="metadata">\
      <track src="subtitles" kind="subtitles">\
      </audio>
      """,
      render(
        .audio(
          attributes: [.autoplay(true), .controls(true), .loop(true), .muted(true), .preload(.auto), .src("src")],
          .track(src: "captions", attributes: [.default(true), .kind(.captions), .label("blob"), .srclang(.en)]),
          .track(src: "chapters", attributes: [.kind(.chapters)]),
          .track(src: "descriptions", attributes: [.kind(.descriptions)]),
          .track(src: "metadata", attributes: [.kind(.metadata)]),
          .track(src: "subtitles", attributes: [.kind(.subtitles)])
        )
      )
    )
    XCTAssertEqual(
      """
      <audio preload="metadata"><track src="blob"></audio>
      """,
      render(
        .audio(
          attributes: [.autoplay(false), .controls(false), .loop(false), .muted(false), .preload(.metadata)],
          .track(src: "blob")
        )
      )
    )
    XCTAssertEqual(
      """
      <video autoplay controls height="42" loop muted poster="blob" preload="none" src="src" width="43">\
      <track src="captions" default kind="captions" label="blob" srclang="en">\
      <track src="chapters" kind="chapters">\
      <track src="descriptions" kind="descriptions">\
      <track src="metadata" kind="metadata">\
      <track src="subtitles" kind="subtitles">\
      </video>
      """,
      render(
        .video(
          attributes: [.autoplay(true), .controls(true), .height(42), .loop(true), .muted(true), .poster("blob"), .preload(.none), .src("src"), .width(43)],
          .track(src: "captions", attributes: [.default(true), .kind(.captions), .label("blob"), .srclang(.en)]),
          .track(src: "chapters", attributes: [.kind(.chapters)]),
          .track(src: "descriptions", attributes: [.kind(.descriptions)]),
          .track(src: "metadata", attributes: [.kind(.metadata)]),
          .track(src: "subtitles", attributes: [.kind(.subtitles)])
        )
      )
    )
    XCTAssertEqual(
      """
      <video><track src="blob"></video>
      """,
      render(
        .video(
          attributes: [.autoplay(false), .controls(false), .loop(false), .muted(false)],
          .track(src: "blob")
        )
      )
    )

    XCTAssertEqual("<meta charset=\"utf-8\">", render(.meta(attributes: [.charset(.utf8)])))

    XCTAssertEqual("<blockquote cite=\"blob\"></blockquote>", render(.blockquote(attributes: [.cite("blob")])))

    let date = Date(timeIntervalSinceReferenceDate: 0)

    XCTAssertEqual(
      """
      <del cite="blob" datetime="2001-01-01T00:00:00Z"></del>
      """,
      render(.del(attributes: [.cite("blob"), .datetime(date)]))
    )

    XCTAssertEqual("<q cite=\"blob\"></q>", render(.q(attributes: [.cite("blob")])))

    XCTAssertEqual("<div class=\"blob\"></div>", render(.div(attributes: [.class("blob")])))

    XCTAssertEqual(
      """
      <td colspan="1" headers="blob" rowspan="1"></td>
      """,
      render(.td(attributes: [.colspan(1), .headers("blob"), .rowspan(1)]))
    )

    XCTAssertEqual("<a contenteditable></a>", render(.a(attributes: [.contenteditable(true)])))
    XCTAssertEqual("<a contenteditable=\"false\"></a>", render(.a(attributes: [.contenteditable(false)])))
    XCTAssertEqual("<a></a>", render(.a(attributes: [.contenteditable(.inherit)])))

    XCTAssertEqual("<a data-blob=\"deadbeef\"></a>", render(.a(attributes: [.data("blob", "deadbeef")])))

    XCTAssertEqual("<time datetime=\"2001-01-01T00:00:00Z\"></time>", render(.time(attributes: [.datetime(date)])))

    XCTAssertEqual("<a dir=\"ltr\"></a>", render(.a(attributes: [.dir(.ltr)])))
    XCTAssertEqual("<a dir=\"rtl\"></a>", render(.a(attributes: [.dir(.rtl)])))
    XCTAssertEqual("<a dir=\"auto\"></a>", render(.a(attributes: [.dir(.auto)])))

    XCTAssertEqual(
      """
      <fieldset disabled name="blob"></fieldset>
      """,
      render(.fieldset(attributes: [.disabled(true), .name("blob")]))
    )
    XCTAssertEqual("<fieldset></fieldset>", render(.fieldset(attributes: [.disabled(false)])))

    XCTAssertEqual("<optgroup disabled></optgroup>", render(.optgroup(attributes: [.disabled(true)])))
    XCTAssertEqual("<optgroup></optgroup>", render(.optgroup(attributes: [.disabled(false)])))

    XCTAssertEqual("<a draggable=\"true\"></a>", render(.a(attributes: [.draggable(true)])))
    XCTAssertEqual("<a draggable=\"false\"></a>", render(.a(attributes: [.draggable(false)])))
    XCTAssertEqual("<a></a>", render(.a(attributes: [.draggable(.auto)])))

    XCTAssertEqual("""
      <form enctype=\"application/x-www-form-urlencoded\"></form>
      """,
      render(.form(attributes: [.enctype(.applicationXWwwFormUrlencoded)]))
    )
    XCTAssertEqual("""
      <form enctype=\"multipart/form-data\"></form>
      """,
      render(.form(attributes: [.enctype(.multipartFormData)]))
    )
    XCTAssertEqual("""
      <form enctype=\"text/plain\"></form>
      """,
      render(.form(attributes: [.enctype(.textPlain)]))
    )

    XCTAssertEqual(
      """
      <label for="blob" form="form"></label>
      """,
      render(.label(attributes: [.for("blob"), .form("form")]))
    )

    XCTAssertEqual(
      """
      <output for="blob" name="blob name"></output>
      """,
      render(.output(attributes: [.for("blob"), .name("blob name")]))
    )

    XCTAssertEqual("<canvas height=\"42\" width=\"43\"></canvas>", render(.canvas(attributes: [.height(42), .width(43)])))
    XCTAssertEqual(
      """
      <iframe height="42" name="blob" sandbox src="src" srcdoc="Hello, world!" width="43"></iframe>
      """,
      render(
        .iframe(
          attributes: [
            .height(42),
            .name("blob"),
            .sandbox(true),
            .src("src"),
            .srcdoc(.text("Hello, world!")),
            .width(43)
          ]
        )
      )
    )
    XCTAssertEqual(
      """
      <iframe></iframe>
      """,
      render(.iframe(attributes: [.sandbox(false)]))
    )
    XCTAssertEqual(
      """
      <iframe sandbox="allow-forms allow-pointer-lock allow-popups allow-presentation allow-same-origin allow-scripts allow-top-navigation"></iframe>
      """,
      render(.iframe(attributes: [.sandbox([.allowForms, .allowPointerLock, .allowPopups, .allowPresentation, .allowSameOrigin, .allowScripts, .allowTopNavigation])]))
    )
    XCTAssertEqual(
      """
      <object height="42" name="blob" width="43"></object>
      """,
      render(.object(attributes: [.height(42), .name("blob"), .width(43)]))
    )
    XCTAssertEqual("<svg height=\"42\" width=\"43\"></svg>", render(.svg(attributes: [.height(42), .width(43)], safe: "")))

    XCTAssertEqual("<a hidden></a>", render(.a(attributes: [.hidden(true)])))
    XCTAssertEqual("<a></a>", render(.a(attributes: [.hidden(false)])))

    XCTAssertEqual("<a href=\"blob\" rel=\"alternate\"></a>", render(.a(attributes: [.href("blob"), .rel(.alternate)])))
    XCTAssertEqual("<area href=\"blob\" rel=\"alternate\">", render(.area(attributes: [.href("blob"), .rel(.alternate)])))
    XCTAssertEqual("<base href=\"blob\">", render(.base(attributes: [.href("blob")])))
    XCTAssertEqual("<link href=\"blob\" rel=\"alternate\">", render(.link(attributes: [.href("blob"), .rel(.alternate)])))

    XCTAssertEqual("<a href=\"mailto:blob@pointfree.co\"></a>", render(.a(attributes: [.mailto("blob@pointfree.co")])))

    XCTAssertEqual(
      """
      <a href="\
      mailto:blob@pointfree.co,blob2@pointfree.co\
      ?cc=blob3@pointfree.co&bcc=blob4@pointfree.co&subject=Help!&body=I%20need%20somebody!\
      "></a>
      """,
      render(
        .a(
          attributes: [
            .mailto(
              ["blob@pointfree.co", "blob2@pointfree.co"],
              cc: ["blob3@pointfree.co"],
              bcc: ["blob4@pointfree.co"],
              subject: "Help!",
              body: "I need somebody!"
            )
          ]
        )
      )
    )

    XCTAssertEqual("<a id=\"blob\"></a>", render(.a(attributes: [.id("blob")])))

    XCTAssertEqual("<a lang=\"en\"></a>", render(.a(attributes: [.lang(.en)])))

    XCTAssertEqual("<details open></details>", render(.details(attributes: [.open(true)])))
    XCTAssertEqual("<details></details>", render(.details(attributes: [.open(false)])))

    XCTAssertEqual("<ol reversed start=\"1\"></ol>", render(.ol(attributes: [.reversed(true), .start(1)])))
    XCTAssertEqual("<ol></ol>", render(.ol(attributes: [.reversed(false)])))

    XCTAssertEqual("<area shape=\"circle\">", render(.area(attributes: [.shape(.circle)])))
    XCTAssertEqual("<area shape=\"poly\">", render(.area(attributes: [.shape(.poly)])))
    XCTAssertEqual("<area>", render(.area(attributes: [.shape(.rect)])))

    XCTAssertEqual("<col span=\"1\">", render(.col(attributes: [.span(1)])))
    XCTAssertEqual("<colgroup span=\"1\"></colgroup>", render(.colgroup(attributes: [.span(1)])))

    XCTAssertEqual("<a spellcheck=\"true\"></a>", render(.a(attributes: [.spellcheck(true)])))
    XCTAssertEqual("<a spellcheck=\"false\"></a>", render(.a(attributes: [.spellcheck(false)])))

    XCTAssertEqual("<embed src=\"src\">", render(.embed(attributes: [.src("src")])))

    XCTAssertEqual("<a style=\"display: none\"></a>", render(.a(attributes: [.style(safe: "display: none")])))

    XCTAssertEqual("<a tabindex=\"1\"></a>", render(.a(attributes: [.tabindex(1)])))

    XCTAssertEqual("<a target=\"_blank\"></a>", render(.a(attributes: [.target(.blank)])))
    XCTAssertEqual("<a></a>", render(.a(attributes: [.target(.self)])))
    XCTAssertEqual("<a target=\"_parent\"></a>", render(.a(attributes: [.target(.parent)])))
    XCTAssertEqual("<a target=\"_top\"></a>", render(.a(attributes: [.target(.top)])))
    XCTAssertEqual("<a target=\"custom\"></a>", render(.a(attributes: [.target(.init(rawValue: "custom"))])))

    XCTAssertEqual("<a title=\"blob\"></a>", render(.a(attributes: [.title("blob")])))

    XCTAssertEqual("<a translate=\"yes\"></a>", render(.a(attributes: [.translate(true)])))
    XCTAssertEqual("<a translate=\"no\"></a>", render(.a(attributes: [.translate(false)])))

    XCTAssertEqual("<button type=\"button\"></button>", render(.button(attributes: [.type(.button)])))
    XCTAssertEqual("<button type=\"reset\"></button>", render(.button(attributes: [.type(.reset)])))
    XCTAssertEqual("<button type=\"submit\"></button>", render(.button(attributes: [.type(.submit)])))

    XCTAssertEqual("<ol type=\"1\"></ol>", render(.ol(attributes: [.type(.decimal)])))
    XCTAssertEqual("<ol type=\"a\"></ol>", render(.ol(attributes: [.type(.lowerAlpha)])))
    XCTAssertEqual("<ol type=\"A\"></ol>", render(.ol(attributes: [.type(.upperAlpha)])))
    XCTAssertEqual("<ol type=\"i\"></ol>", render(.ol(attributes: [.type(.lowerRoman)])))
    XCTAssertEqual("<ol type=\"I\"></ol>", render(.ol(attributes: [.type(.upperRoman)])))
  }
}

