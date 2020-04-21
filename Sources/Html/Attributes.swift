import Foundation

public struct Attribute<Element> {
  public let key: String
  public let value: String?

  public init(_ key: String, _ value: String?) {
    self.key = key
    self.value = value
  }
}

extension Attribute {
  /// All HTML elements may have the `accesskey` content attribute set. The `accesskey` attribute's value is used by the user agent as a guide for creating a keyboard shortcut that activates or focuses the element.
  ///
  /// - Parameter value: Used by the user agent as a guide for creating a keyboard shortcut that activates or focuses the element.
  public static func accesskey(_ value: Character) -> Attribute {
    return .init("accesskey", String(value))
  }

  /// When specified on HTML elements, the `class` attribute must have a value that is a set of space-separated tokens representing the various classes that the element belongs to.
  ///
  /// - Parameter value: A set of space-separated tokens.
  public static func `class`(_ value: String) -> Attribute {
    return .init("class", value)
  }

  public enum Contenteditable: String, ExpressibleByBooleanLiteral {
    case `true` = ""
    case `false`
    case inherit

    public init(booleanLiteral value: Bool) {
      self = value ? .true : .false
    }
  }

  /// Make a document region editable.
  ///
  /// - Parameter value: Should a document region be editable.
  public static func contenteditable(_ value: Contenteditable) -> Attribute {
    return .init("contenteditable", value == .inherit ? nil : value.rawValue)
  }

  /// Adds a `data`-prefixed attribute to the element.
  ///
  /// - Parameters:
  ///   - name: The attribute suffix.
  ///   - value: The value.
  public static func data(_ name: StaticString, _ value: String) -> Attribute {
    return .init("data-\(name)", value)
  }

  public enum Direction: String {
    case ltr
    case rtl
    case auto
  }

  public static func dir(_ value: Direction) -> Attribute {
    return .init("dir", value.rawValue)
  }

  public enum Draggable: String, ExpressibleByBooleanLiteral {
    /// The element is draggable.
    case `true`

    /// The element is not draggable.
    case `false`

    /// The default draggable behavior of the user agent.
    case auto

    public init(booleanLiteral value: Bool) {
      self = value ? .true : .false
    }
  }

  /// Whether or not an element is draggable.
  ///
  /// - Parameter value: Whether or not an element is draggable.
  public static func draggable(_ value: Draggable) -> Attribute {
    return .init("draggable", value == .auto ? nil : value.rawValue)
  }

  /// Hide the element.
  ///
  /// - Parameter value: Hide the element.
  public static func hidden(_ value: Bool) -> Attribute {
    return .init("hidden", value ? "" : nil)
  }

  /// When specified on HTML elements, the `id` attribute value must be unique amongst all the IDs in the element's tree and must contain at least one character. The value must not contain any space characters.
  ///
  /// - Parameter value: A unique identifier.
  public static func id(_ value: String) -> Attribute {
    return .init("id", value)
  }

  public enum Language: String {
    case aa
    case ab
    case ae
    case af
    case ak
    case am
    case an
    case ar
    case `as`
    case av
    case ay
    case az
    case ba
    case be
    case bg
    case bh
    case bi
    case bm
    case bn
    case bo
    case br
    case bs
    case ca
    case ce
    case ch
    case co
    case cr
    case cs
    case cu
    case cv
    case cy
    case da
    case de
    case dv
    case dz
    case ee
    case el
    case en
    case eo
    case es
    case et
    case eu
    case fa
    case ff
    case fi
    case fj
    case fo
    case fr
    case fy
    case ga
    case gd
    case gl
    case gn
    case gu
    case gv
    case ha
    case he
    case hi
    case ho
    case hr
    case ht
    case hu
    case hy
    case hz
    case ia
    case id
    case ie
    case ig
    case ii
    case ik
    case `in`
    case io
    case `is`
    case it
    case iu
    case ja
    case ji
    case jv
    case ka
    case kg
    case ki
    case kj
    case kk
    case kl
    case km
    case kn
    case ko
    case kr
    case ks
    case ku
    case kv
    case kw
    case ky
    case la
    case lb
    case lg
    case li
    case ln
    case lo
    case lt
    case lu
    case lv
    case mg
    case mh
    case mi
    case mk
    case ml
    case mn
    case mr
    case ms
    case mt
    case my
    case na
    case nb
    case nd
    case ne
    case nl
    case nn
    case no
    case nr
    case nv
    case ny
    case oc
    case oj
    case om
    case or
    case os
    case pa
    case pi
    case pl
    case ps
    case pt
    case qu
    case rm
    case rn
    case ro
    case ru
    case rw
    case sa
    case sc
    case sd
    case se
    case sg
    case si
    case sk
    case sl
    case sm
    case sn
    case so
    case sq
    case sr
    case ss
    case st
    case su
    case sv
    case sw
    case ta
    case te
    case tg
    case th
    case ti
    case tk
    case tl
    case tn
    case to
    case tr
    case ts
    case tt
    case tw
    case ty
    case ug
    case uk
    case ur
    case uz
    case ve
    case vi
    case vo
    case wa
    case wo
    case xh
    case yi
    case yo
    case za
    case zu
    case zh
    case zhHans = "zh-Hans"
    case zhHant = "zh-Hant"
    case unknown = ""
  }

  /// The `lang` attribute specifies the primary language for the element's contents and for any of the element's attributes that contain text.
  ///
  /// - Parameter value: A valid BCP 47 language tag, or the empty string. Setting the attribute to the empty string indicates that the primary language is unknown.
  public static func lang(_ value: Language) -> Attribute {
    return .init("lang", value.rawValue)
  }

  public static func spellcheck(_ value: Bool) -> Attribute {
    return .init("spellcheck", String(value))
  }

  /// This is a style attribute as defined by the _CSS Style Attributes_ specification.
  ///
  /// - Parameter value: A CSS style.
  public static func style(safe value: StaticString) -> Attribute {
    return style(unsafe: String(describing: value))
  }

  /// This is a style attribute as defined by the _CSS Style Attributes_ specification.
  ///
  /// - Parameter value: A CSS style.
  public static func style(unsafe value: String) -> Attribute {
    return .init("style", String(describing: value))
  }

  /// The `tabindex` content attribute allows authors to indicate that an element is supposed to be focusable, whether it is supposed to be reachable using sequential focus navigation and, optionally, to suggest where in the sequential focus navigation order the element appears.
  ///
  /// - Parameter value: The sequential focus navigation order the element appears.
  public static func tabindex(_ value: Int) -> Attribute {
    return .init("tabindex", String(value))
  }

  /// The `title` attribute represents advisory information for the element, such as would be appropriate for a tooltip.
  ///
  /// - Parameter value: Advisory information.
  public static func title(_ value: String) -> Attribute {
    return .init("title", value)
  }

  public enum Translate: String, ExpressibleByBooleanLiteral {
    case yes
    case no

    public init(booleanLiteral value: Bool) {
      self = value ? .yes : .no
    }
  }

  /// Whether or not an element's attribute values and the values of its text node children are to be translated when the page is localized.
  ///
  /// - Parameter value: Whether or not an element's attribute values and the values of its text node children are to be translated when the page is localized.
  public static func translate(_ value: Translate) -> Attribute {
    return .init("translate", value.rawValue)
  }
}

extension Attribute where Element == Tag.A {
  /// Email address of a hyperlink.
  ///
  /// - Parameters:
  ///   - address: One or more email addresses for the "to" field.
  ///   - cc: Zero or more email addresses for the "cc" field.
  ///   - bcc: Zero or more email addresses for the "bcc" field.
  ///   - subject: An optional email subject.
  ///   - body: An optional email body.
  /// - Returns: A "mailto" URL for hyperlinks.
  public static func mailto(
    _ addresses: String...,
    cc: [String] = [],
    bcc: [String] = [],
    subject: String = "",
    body: String = ""
    )
    -> Attribute {

      return .mailto(addresses, cc: cc, bcc: bcc, subject: subject, body: body)
  }

  /// Email address of a hyperlink.
  ///
  /// - Parameters:
  ///   - address: One or more email addresses for the "to" field.
  ///   - cc: Zero or more email addresses for the "cc" field.
  ///   - bcc: Zero or more email addresses for the "bcc" field.
  ///   - subject: An optional email subject.
  ///   - body: An optional email body.
  /// - Returns: A "mailto" URL for hyperlinks.
  public static func mailto(
    _ addresses: [String],
    cc: [String] = [],
    bcc: [String] = [],
    subject: String = "",
    body: String = ""
    )
    -> Attribute {

      var urlComponents = URLComponents()
      urlComponents.scheme = "mailto"
      urlComponents.path = addresses.joined(separator: ",")
      let queryItems = [
        cc.isEmpty ? nil : URLQueryItem(name: "cc", value: cc.joined(separator: ",")),
        bcc.isEmpty ? nil : URLQueryItem(name: "bcc", value: bcc.joined(separator: ",")),
        subject.isEmpty ? nil : URLQueryItem(name: "subject", value: subject),
        body.isEmpty ? nil : URLQueryItem(name: "body", value: body)
        ]
        .compactMap { $0 }
      urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
      return href(urlComponents.string ?? "")
  }
}

/// The kind of shape to be created in an image map.
public enum AreaShape: String {
  case circle
  //  case `default`
  case poly
  case rect = ""
}

extension Attribute where Element == Tag.Area {
  /// The kind of shape to be created in an image map.
  ///
  /// - Parameter value: The kind of shape to be created in an image map.
  public static func shape(_ value: AreaShape) -> Attribute {
    return .init("shape", value == .rect ? nil : value.rawValue)
  }
}

/// Type of button.
public enum ButtonType: String {
  /// Does nothing.
  case button

  /// Resets the form.
  case reset

  /// Submits the form.
  case submit
}

extension Attribute where Element == Tag.Button {
  /// Type of button.
  ///
  /// - Parameter value: Type of button.
  public static func type(_ value: ButtonType) -> Attribute {
    return .init("type", value.rawValue)
  }
}

extension Attribute where Element == Tag.Details {
  /// Whether the details are visible.
  ///
  /// - Parameter value: Whether the details are visible.
  public static func open(_ value: Bool) -> Attribute {
    return .init("open", value ? "" : nil)
  }
}

/// HTTP method to use for form submission.
public enum FormMethod: String {
  /// Submitting the form is intended to close the dialog box in which the form finds itself, if any, and otherwise not submit.
  case dialog = "dialog"

  /// The HTTP GET method.
  case get = ""

  /// The HTTP POST method.
  case post = "post"
}

extension Attribute where Element == Tag.Form {
  /// URL to use for form submission.
  ///
  /// - Parameter value: URL to use for form submission.
  public static func action(_ value: String) -> Attribute {
    return .init("action", value)
  }

  public struct Enctype: RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
    }

    public static let applicationXWwwFormUrlencoded = Enctype(rawValue: "application/x-www-form-urlencoded")
    public static let multipartFormData = Enctype(rawValue: "multipart/form-data")
    public static let textPlain = Enctype(rawValue: "text/plain")
  }

  /// The type of form encoding.
  ///
  /// - Parameter value: Enctype to use for form encoding.
  public static func enctype(_ value: Enctype) -> Attribute {
    return .init("enctype", value.rawValue)
  }

  /// HTTP method to use for form submission.
  ///
  /// - Parameter value: HTTP method to use for form submission.
  public static func method(_ value: FormMethod) -> Attribute {
    let rawValue = value.rawValue
    return .init("method", rawValue.isEmpty ? nil : rawValue)
  }

  /// Bypass form control validation for form submission.
  ///
  /// - Parameter value: Bypass form control validation for form submission.
  public static func novalidate(_ value: Bool) -> Attribute {
    return .init("novalidate", value ? "" : nil)
  }
}

public enum IframeSandbox: String {
  /// Re-enable forms.
  case allowForms = "allow-forms"

  /// Re-enable the pointer lock API.
  case allowPointerLock = "allow-pointer-lock"

  /// Re-enable popups.
  case allowPopups = "allow-popups"

  /// Re-enable the presentation API.
  case allowPresentation = "allow-presentation"

  /// Causes the content to be treated as being from its real origin instead of forcing it into a unique origin.
  case allowSameOrigin = "allow-same-origin"

  /// Re-enable scripts.
  case allowScripts = "allow-scripts"

  /// Allows the content to navigate its top-level browsing context.
  case allowTopNavigation = "allow-top-navigation"
}

extension Attribute where Element == Tag.Iframe {
  /// Enables a set of extra restrictions on any content hosted by the `<iframe>`.
  ///
  /// - Parameter value: Sandbox options.
  public static func sandbox(_ value: [IframeSandbox]) -> Attribute {
    return .init("sandbox", value.map { $0.rawValue }.joined(separator: " "))
  }

  /// Enables a set of extra restrictions on any content hosted by the `<iframe>`.
  ///
  /// - Parameter value: Whether or not to sandbox the `<iframe>`.
  public static func sandbox(_ value: Bool) -> Attribute {
    return .init("sandbox", value ? "" : nil)
  }

  /// A document to render in the `iframe`.
  ///
  /// - Parameter value: A document to render in the `iframe`.
  public static func srcdoc(_ value: Node...) -> Attribute {
    return .init("srcdoc", render(value))
  }
}

public enum InputType: String {
  case button
  case checkbox
  case color
  case date
  case datetimeLocal = "datetime-local"
  case email
  case file
  case hidden
  case image
  case month
  case number
  case password
  case radio
  case range
  case reset
  case search
  case submit
  case tel
  case text
  case time
  case url
  case week
}

public struct Accept: RawRepresentable {
  public let rawValue: String

  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  public static let audio = Accept(rawValue: "audio/*")
  public static let image = Accept(rawValue: "image/*")
  public static let video = Accept(rawValue: "video/*")

  public static func file(_ type: String) -> Accept {
    return .init(rawValue: type.hasPrefix(".") ? type : "." + type)
  }

  public static func mime(_ type: MediaType) -> Accept {
    let mimeTypeOnly = type.description.split(separator: ";")[0]
    return .init(rawValue: String(mimeTypeOnly))
  }
}

extension Attribute where Element == Tag.Input {
  /// Whether the command or control is checked.
  ///
  /// - Parameter value: Whether the command or control is checked.
  public static func checked(_ value: Bool) -> Attribute {
    return .init("checked", value ? "" : nil)
  }

  /// Pattern to be matched by the form control's value.
  ///
  /// - Parameter value: Pattern to be matched by the form control's value.
  public static func pattern(_ value: String) -> Attribute {
    return .init("pattern", value)
  }

  /// Granularity to be matched by the form control's value.
  ///
  /// - Parameter value: Granularity to be matched by the form control's value.
  public static func step(_ value: Int) -> Attribute {
    return .init("step", String(value))
  }

  public static func type(_ value: InputType) -> Attribute {
    return .init("type", value.rawValue)
  }

  /// Pattern or file types to be selected (only for type="file")
  ///
  /// - Parameter value:
  /// 	The file extension or media type the user can select,
  ///   such as ".pdf" or "image/*"
  public static func accept(_ value: Accept...) -> Attribute {
    return .init("accept", value.map { $0.rawValue }.joined(separator: ", "))
  }
}

extension Attribute where Element == Tag.Meta {
  /// Value of the `<meta>` element.
  ///
  /// - Parameter value: Value of the element.
  public static func content(_ value: String) -> Attribute {
    return .init("content", value)
  }
}

public enum ListType: String {
  /// Decimal numbers: `1.`, `2.`, `3.`...`3999.`, `4000.`, `4001.`
  case decimal = "1"

  /// Lowercase Latin alphabet: `a.`, `b.`, `c.`...`ewu.`, `ewv.`, `eww.`
  case lowerAlpha = "a"

  /// Uppercase Latin alphabet: `A.`, `B.`, `C.`...`EWU.`, `EWV.`, `EWW.`
  case upperAlpha = "A"

  /// Lowercase Roman numerals: `1.`, `2.`, `3.`...`mmmcmxcix.`, `i̅v̅.`, `i̅v̅i.`
  case lowerRoman = "i"

  /// Uppercase Roman numerals: `I.`, `II.`, `III.`...`MMMCMXCIX.`, `I̅V̅.`, `I̅V̅I.`
  case upperRoman = "I"
}

extension Attribute where Element == Tag.Ol {
  /// Number the list backwards.
  ///
  /// - Parameter value: Number the list backwards.
  public static func reversed(_ value: Bool) -> Attribute {
    return .init("reversed", value ? "" : nil)
  }

  /// Ordinal value of the first item.
  ///
  /// - Parameter value: Ordinal value of the first item.
  public static func start(_ value: Int) -> Attribute {
    return .init("start", String(value))
  }

  /// Kind of list marker.
  ///
  /// - Parameter value: Kind of list marker.
  public static func type(_ value: ListType) -> Attribute {
    return .init("type", value.rawValue)
  }
}

extension Attribute where Element == Tag.Option {
  /// Whether the option is selected by default.
  ///
  /// - Parameter value: Whether the option is selected by default.
  public static func selected(_ value: Bool) -> Attribute {
    return .init("selected", value ? "" : nil)
  }
}

extension Attribute where Element == Tag.Script {
  /// Execute script in parallel.
  ///
  /// - Parameter value: Execute script in parallel.
  public static func async(_ value: Bool) -> Attribute {
    return .init("async", value ? "" : nil)
  }

  /// Defer script execution.
  ///
  /// - Parameter value: Defer script execution.
  public static func `defer`(_ value: Bool) -> Attribute {
    return .init("defer", value ? "" : nil)
  }

  /// Cryptographic nonce used in Content Security Policy checks.
  ///
  /// - Parameter value: Cryptographic nonce used in Content Security Policy checks.
  public static func nonce(_ value: String) -> Attribute {
    return .init("nonce", value)
  }
}

extension Attribute where Element == Tag.Source {
  /// Applicable media.
  ///
  /// - Parameter value: A media query list.
  public static func media(_ value: String) -> Attribute {
    return .init("media", value)
  }

  /// Images to use in different situations (e.g., high-resolution displays, small monitors, etc).
  ///
  /// - Parameter value: Images to use in different situations (e.g., high-resolution displays, small monitors, etc).
  public static func srcset(_ value: String) -> Attribute {
    return .init("srcset", value)
  }
}

public enum TextareaWrap: String {
  /// Indicates that the text in the `<textarea>` is to have newlines added by the user agent so that the text is wrapped when it is submitted.
  ///
  /// If the element's `wrap` attribute is in the `hard` state, the `cols` attribute must be specified.
  case hard

  /// Indicates that the text in the `<textarea>` is not to be wrapped when it is submitted (though it can still be wrapped in the rendering).
  case soft
}

extension Attribute where Element == Tag.Textarea {
  /// Maximum number of characters per line.
  ///
  /// - Parameter value: Maximum number of characters per line.
  public static func cols(_ value: Int) -> Attribute {
    return .init("cols", String(value))
  }

  /// Number of lines to show.
  ///
  /// - Parameter value: Number of lines to show.
  public static func rows(_ value: Int) -> Attribute {
    return .init("rows", String(value))
  }

  /// How the value of the form control is to be wrapped for form submission.
  ///
  /// - Parameter value: How the value of the form control is to be wrapped for form submission.
  public static func wrap(_ value: TextareaWrap) -> Attribute {
    return .init("wrap", value.rawValue)
  }
}

/// Specifies which cells the header cell applies to.
public enum ThScope: String {
  /// The **auto** state makes the header cell apply to a set of cells selected based on context.
  case auto = ""

  /// The **column** state means the header cell applies to some of the subsequent cells in the same column(s).
  case col

  /// The **col group** state means the header cell applies to all the remaining cells in the column group. A `<th>` element's `scope` attribute must not be in the column group state if the element is not anchored in a column group.
  case colgroup

  /// The **row** state means the header cell applies to some of the subsequent cells in the same row(s).
  case row

  /// The **row group** state means the header cell applies to all the remaining cells in the row group. A `<th>` element's `scope` attribute must not be in the row group state if the element is not anchored in a row group.
  case rowgroup
}

extension Attribute where Element == Tag.Th {
  /// Alternative label to use for the header cell when referencing the cell in other contexts.
  ///
  /// - Parameter value: Alternative label to use for the header cell when referencing the cell in other contexts.
  public static func abbr(_ value: String) -> Attribute {
    return .init("abbr", value)
  }

  /// Specifies which cells the header cell applies to.
  ///
  /// - Parameter value: Specifies which cells the header cell applies to.
  public static func scope(_ value: ThScope) -> Attribute {
    return .init("scope", value.rawValue)
  }
}

/// Kinds of text tracks for `<track>` elements.
public enum TrackKind: String {
  /// Transcription or translation of the dialog, sound effects, relevant musical cues, and other relevant audio information, suitable for when sound is unavailable or not clearly audible (e.g., because it is muted, drowned-out by ambient noise, or because the user is deaf). Overlaid on the video; labeled as appropriate for the hard-of-hearing.
  case captions

  /// Chapter titles, intended to be used for navigating the media resource. Displayed as an interactive (potentially nested) list in the user agent's interface.
  case chapters

  /// Textual descriptions of the video component of the media resource, intended for audio synthesis when the visual component is obscured, unavailable, or not usable (e.g., because the user is interacting with the application without a screen while driving, or because the user is blind). Synthesized as audio
  case descriptions

  /// Tracks intended for use from script. Not displayed by the user agent.
  case metadata

  /// Transcription or translation of the dialog, suitable for when the sound is available but not understood (e.g., because the user does not understand the language of the media resource's audio track). Overlaid on the video.
  case subtitles
}

extension Attribute where Element == Tag.Track {
  public static func `default`(_ value: Bool) -> Attribute {
    return .init("default", value ? "" : nil)
  }

  /// The type of text track.
  ///
  /// - Parameter value: The type of text track.
  public static func kind(_ value: TrackKind) -> Attribute {
    return .init("kind", value.rawValue)
  }

  /// User-visible label for a `<track>` element.
  ///
  /// - Parameter value: User-visible label.
  public static func label(_ value: String) -> Attribute {
    return .init("label", value)
  }

  /// Language of the text track.
  ///
  /// - Parameter value: Language of the text track.
  public static func srclang(_ value: Language) -> Attribute {
    return .init("srclang", value.rawValue)
  }
}

extension Attribute where Element == Tag.Video {
  public static func poster(_ value: String) -> Attribute {
    return .init("poster", value)
  }
}

/// Conforming elements can have an `alt` attribute. Includes `<area>`, `<img>` and `<input>` elements.
public protocol HasAlt {}

extension Tag.Area: HasAlt {}
extension Tag.Img: HasAlt {}
extension Tag.Input: HasAlt {}

extension Attribute where Element: HasAlt {
  /// Replacement text for use when images are not available. For `<area>`, `<img>`, and `<input>` elements.
  ///
  /// - Parameter value: Replacement text for use when images are not available.
  public static func alt(_ value: String) -> Attribute {
    return .init("alt", value)
  }
}

/// Conforming elements can have an `autofocus` attribute. Includes `<button>`, `<input>`, `<select>`, and `<textarea>` elements.
public protocol HasAutofocus {}

extension Tag.Button: HasAutofocus {}
extension Tag.Input: HasAutofocus {}
extension Tag.Select: HasAutofocus {}
extension Tag.Textarea: HasAutofocus {}

extension Attribute where Element: HasAutofocus {
  /// The `autofocus` content attribute allows the author to indicate that a control is to be focused as soon as the page is loaded or as soon as the `dialog` within which it finds itself is shown, allowing the user to just start typing without having to manually focus the main control.
  ///
  /// - Parameter value: Automatically focus the form control when the page is loaded.
  public static func autofocus(_ value: Bool) -> Attribute {
    return .init("autofocus", value ? "" : nil)
  }
}

/// Conforming elements can have an `autoplay` attribute. Includes `<audio>` and `<video>` elements.
public protocol HasAutoplay {}

extension Tag.Audio: HasAutoplay {}
extension Tag.Video: HasAutoplay {}

extension Attribute where Element: HasAutoplay {
  /// Hint that the media resource can be started automatically when the page is loaded.
  ///
  /// - Parameter value: Hint that the media resource can be started automatically when the page is loaded.
  public static func autoplay(_ value: Bool) -> Attribute {
    return .init("autoplay", value ? "" : nil)
  }
}

/// Conforming elements can have a `charset` attribute. Includes `<meta>` and `<script>` elements.
public protocol HasCharset {}

extension Tag.Meta: HasCharset {}
extension Tag.Script: HasCharset {}

extension Attribute where Element: HasCharset {
  /// Character encoding declaration.
  ///
  /// - Parameter value: A character encoding declaration.
  public static func charset(_ value: Charset) -> Attribute {
    return .init("charset", value.rawValue)
  }
}

/// Conforming elements can have a `cite` attribute. Includes `<blockquote>`, `<del>`, `<ins>`, and `<q>` elements.
public protocol HasCite {}

extension Tag.Blockquote: HasCite {}
extension Tag.Del: HasCite {}
extension Tag.Ins: HasCite {}
extension Tag.Q: HasCite {}

extension Attribute where Element: HasCite {
  /// Link to the source of the quotation.
  ///
  /// - Parameter value: Link to the source of the quotation or more information about the edit.
  public static func cite(_ value: String) -> Attribute {
    return .init("cite", value)
  }
}

/// Conforming elements can have a `colspan` attribute. Includes `<td>` and `<th>` elements.
public protocol HasColspan {}

extension Tag.Td: HasColspan {}
extension Tag.Th: HasColspan {}

extension Attribute where Element: HasColspan {
  /// Number of columns that the cell is to span.
  ///
  /// - Parameter value: Number of columns that the cell is to span.
  public static func colspan(_ value: Int) -> Attribute {
    return .init("colspan", String(value))
  }
}

/// Conforming elements can have a `controls` attribute. Includes `<audio>` and `<video>` elements.
public protocol HasControls {}

extension Tag.Audio: HasControls {}
extension Tag.Video: HasControls {}

extension Attribute where Element: HasControls {
  /// If present, it indicates that the author has not provided a scripted controller and would like the user agent to provide its own set of controls.
  ///
  /// - Parameter value: Show user agent controls.
  public static func controls(_ value: Bool) -> Attribute {
    return .init("controls", value ? "" : nil)
  }
}

/// Conforming elements can have a `crossorigin` attribute. Includes `<img>` and `<script>` elements.
public protocol HasCrossorigin {}

extension Tag.Img: HasCrossorigin {}
extension Tag.Script: HasCrossorigin {}

extension Attribute where Element: HasCrossorigin {
  public enum Crossorigin: String {
    /// Requests for the element will have their mode set to "`cors`" and their credentials mode set to "`same-origin`".
    case anonymous = ""

    /// Requests for the element will have their mode set to "`cors`" and their credentials mode set to "`include`".
    case useCredentials = "use-credentials"
  }

  /// How the element handles crossorigin requests.
  ///
  /// - Parameter value: How the element handles crossorigin requests.
  public static func crossorigin(_ value: Crossorigin) -> Attribute {
    return .init("crossorigin", value.rawValue)
  }
}

private let iso8601DateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.locale = Locale(identifier: "en_US_POSIX")
  formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
  formatter.timeZone = TimeZone(identifier: "UTC")
  return formatter
}()

/// Conforming elements can have a `datetime` attribute. Includes `<del>`, `<ins>`, and `<time>` elements.
public protocol HasDatetime {}

extension Tag.Del: HasDatetime {}
extension Tag.Ins: HasDatetime {}
extension Tag.Time: HasDatetime {}

extension Attribute where Element: HasDatetime {
  public static func datetime(_ value: Date) -> Attribute {
    return .init("datetime", iso8601DateFormatter.string(from: value))
  }
}

/// Conforming elements can have a `disabled` attribute. Includes `<button>`, `<fieldset>`, `<input>`, `<optgroup>`, `<option>`, `<select>`, and `<textarea>` elements.
public protocol HasDisabled {}

extension Tag.Button: HasDisabled {}
extension Tag.Fieldset: HasDisabled {}
extension Tag.Input: HasDisabled {}
extension Tag.Optgroup: HasDisabled {}
extension Tag.Option: HasDisabled {}
extension Tag.Select: HasDisabled {}
extension Tag.Textarea: HasDisabled {}

extension Attribute where Element: HasDisabled {
  /// Whether the form control is disabled.
  ///
  /// - Parameter value: Whether the form control is disabled.
  public static func disabled(_ value: Bool) -> Attribute {
    return .init("disabled", value ? "" : nil)
  }
}

/// Conforming elements can have a `for` attribute. Includes `<label>` and `<output>` elements.
public protocol HasFor {}

extension Tag.Label: HasFor {}
extension Tag.Output: HasFor {}

extension Attribute where Element: HasFor {
  /// Associate the label or output with form control.
  ///
  /// - Parameter value: The `id` of the form control
  public static func `for`(_ value: String) -> Attribute {
    return .init("for", value)
  }
}

/// Conforming elements can have a `form` attribute. Includes `<button>`, `<fieldset>`, `<input>`, `<label>`, `<meter>`, `<object>`, `<output>`, `<select>`, and `<textarea>` elements.
public protocol HasForm {}

extension Tag.Button: HasForm {}
extension Tag.Fieldset: HasForm {}
extension Tag.Input: HasForm {}
extension Tag.Label: HasForm {}
extension Tag.Meter: HasForm {}
extension Tag.Object: HasForm {}
extension Tag.Output: HasForm {}
extension Tag.Select: HasForm {}
extension Tag.Textarea: HasForm {}

extension Attribute where Element: HasForm {
  /// Associates the control with a `<form>` element.
  ///
  /// - Parameter value: The associated `<form>` element's `id`.
  public static func form(_ value: String) -> Attribute {
    return .init("form", value)
  }
}

/// Conforming elements can have a `headers` attribute. Includes `<td>` and `<th>` elements.
public protocol HasHeaders {}

extension Tag.Td: HasHeaders {}
extension Tag.Th: HasHeaders {}

extension Attribute where Element: HasHeaders {
  /// The header cells for this cell.
  ///
  /// - Parameter value: The header cells for this cell.
  public static func headers(_ value: String) -> Attribute {
    return .init("headers", value)
  }
}

/// Conforming elements can have a `height` attribute. Includes `<canvas>`, `<embed>`, `<iframe>`, `<img>`, `<input>`, `<object>`, `<svg>`, and `<video>` elements.
public protocol HasHeight {}

extension Tag.Canvas: HasHeight {}
extension Tag.Embed: HasHeight {}
extension Tag.Iframe: HasHeight {}
extension Tag.Img: HasHeight {}
extension Tag.Input: HasHeight {}
extension Tag.Object: HasHeight {}
extension Tag.Svg: HasHeight {}
extension Tag.Video: HasHeight {}

extension Attribute where Element: HasHeight {
  /// Vertical dimension.
  ///
  /// - Parameter value: Vertical dimension.
  public static func height(_ value: Int) -> Attribute {
    return .init("height", String(value))
  }
}

/// Conforming elements can have an `href` attribute. Includes `<a>`, `<area>`, `<base>`, and `<link>` elements.
public protocol HasHref {}

extension Tag.A: HasHref {}
extension Tag.Area: HasHref {}
extension Tag.Base: HasHref {}
extension Tag.Link: HasHref {}

extension Attribute where Element: HasHref {
  /// Address of a hyperlink.
  ///
  /// - Parameter value: Address of a hyperlink.
  public static func href(_ value: String) -> Attribute {
    return .init("href", value)
  }
}

/// Conforming elements can have a `loop` attribute. Includes `<audio>` and `<video>` elements.
public protocol HasLoop {}

extension Tag.Audio: HasLoop {}
extension Tag.Video: HasLoop {}

extension Attribute where Element: HasLoop {
  public static func loop(_ value: Bool) -> Attribute {
    return .init("loop", value ? "" : nil)
  }
}

/// Conforming elements can have a `max` attribute. Includes `<input>`, `<meter>`, and `<progress>` elements.
public protocol HasMax {}

extension Tag.Input: HasMax {}
extension Tag.Meter: HasMax {}
extension Tag.Progress: HasMax {}

extension Attribute where Element: HasMax {
  /// Maximum value.
  ///
  /// - Parameter value: Maximum value.
  public static func max(_ value: Double) -> Attribute {
    return .init("max", String(value))
  }

  // TODO: Truncate ".0" in single function above.
  /// Maximum value.
  ///
  /// - Parameter value: Maximum value.
  public static func max(_ value: Int) -> Attribute {
    return .init("max", String(value))
  }
}

/// Conforming elements can have a `maxlength` attribute. Includes `<input>` and `<textarea>` elements.
public protocol HasMaxlength {}

extension Tag.Input: HasMaxlength {}
extension Tag.Textarea: HasMaxlength {}

extension Attribute where Element: HasMaxlength {
  /// Maximum length of value.
  ///
  /// - Parameter value: Maximum length of value.
  public static func maxlength(_ value: Int) -> Attribute {
    return .init("maxlength", String(value))
  }
}

/// Conforming elements can have a `min` attribute. Includes `<input>`, `<meter>`, and `<progress>` elements.
public protocol HasMin {}

extension Tag.Input: HasMin {}
extension Tag.Meter: HasMin {}
extension Tag.Progress: HasMin {}

extension Attribute where Element: HasMin {
  /// Minimum value.
  ///
  /// - Parameter value: Minimum value.
  public static func min(_ value: Double) -> Attribute {
    return .init("min", String(value))
  }

  // TODO: Truncate ".0" in single function above.
  /// Minimum value.
  ///
  /// - Parameter value: Minimum value.
  public static func min(_ value: Int) -> Attribute {
    return .init("min", String(value))
  }
}

/// Conforming elements can have a `minlength` attribute. Includes `<input>` and `<textarea>` elements.
public protocol HasMinlength {}

extension Tag.Input: HasMinlength {}
extension Tag.Textarea: HasMinlength {}

extension Attribute where Element: HasMinlength {
  /// Minimum length of value.
  ///
  /// - Parameter value: Minimum length of value.
  public static func minlength(_ value: Int) -> Attribute {
    return .init("minlength", String(value))
  }
}

/// Conforming elements can have a `multiple` attribute. Includes `<input>` and `<select>` elements.
public protocol HasMultiple {}

extension Tag.Input: HasMultiple {}
extension Tag.Select: HasMultiple {}

extension Attribute where Element: HasMultiple {
  /// Whether to allow multiple values.
  ///
  /// - Parameter value: Whether to allow multiple values.
  public static func multiple(_ value: Bool) -> Attribute {
    return .init("multiple", value ? "" : nil)
  }
}

/// Conforming elements can have a `muted` attribute. Includes `<audio>` and `<video>` elements.
public protocol HasMuted {}

extension Tag.Audio: HasMuted {}
extension Tag.Video: HasMuted {}

extension Attribute where Element: HasMuted {
  /// Whether to mute the media resource by default.
  ///
  /// - Parameter value: Whether to mute the media resource by default.
  public static func muted(_ value: Bool) -> Attribute {
    return .init("muted", value ? "" : nil)
  }
}

public protocol HasName {}

extension Tag.Button: HasName {}
extension Tag.Fieldset: HasName {}
extension Tag.Form: HasName {}
extension Tag.Iframe: HasName {}
extension Tag.Input: HasName {}
extension Tag.Map: HasName {}
extension Tag.Object: HasName {}
extension Tag.Output: HasName {}
extension Tag.Select: HasName {}
extension Tag.Textarea: HasName {}

extension Attribute where Element: HasName {
  /// Name of form control to use for form submission and in the form.elements API.
  ///
  /// - Parameter value: Name of form control.
  public static func name(_ value: String) -> Attribute {
    return .init("name", value)
  }
}

/// Conforming elements can have a `placeholder` attribute. Includes `<input>` and `<textarea>` elements.
public protocol HasPlaceholder {}

extension Tag.Input: HasPlaceholder {}
extension Tag.Textarea: HasPlaceholder {}

extension Attribute where Element: HasPlaceholder {
  /// User-visible label to be placed within the form control.
  ///
  /// - Parameter value: User-visible label to be placed within the form control.
  public static func placeholder(_ value: String) -> Attribute {
    return .init("placeholder", value)
  }
}

/// Conforming elements can have a `preload` attribute. Includes `<audio>` and `<video>` elements.
public protocol HasPreload {}

extension Tag.Audio: HasPreload {}
extension Tag.Video: HasPreload {}

extension Attribute where Element: HasPreload {
  public enum Preload: String {
    /// Hints to the user agent that the user agent can put the user's needs first without risk to the server, up to and including optimistically downloading the entire resource.
    case auto = ""

    /// Hints to the user agent that the author does not expect the user to need the media resource, but that fetching the resource metadata (dimensions, track list, duration, etc), and maybe even the first few frames, is reasonable. If the user agent precisely fetches no more than the metadata, then the media element will end up with its readyState attribute set to `HAVE_METADATA`; typically though, some frames will be obtained as well and it will probably be `HAVE_CURRENT_DATA` or `HAVE_FUTURE_DATA`. When the media resource is playing, hints to the user agent that bandwidth is to be considered scarce, e.g., suggesting throttling the download so that the media data is obtained at the slowest possible rate that still maintains consistent playback.
    case metadata

    /// Hints to the user agent that either the author does not expect the user to need the media resource, or that the server wants to minimize unnecessary traffic. This state does not provide a hint regarding how aggressively to actually download the media resource if buffering starts anyway (e.g., once the user hits "play").
    case none
  }

  /// Hints how much buffering the media resource will likely need.
  ///
  /// - Parameter value: Hints how much buffering the media resource will likely need.
  public static func preload(_ value: Preload) -> Attribute {
    return .init("preload", value.rawValue)
  }
}

/// Conforming elements can have a `readonly` attribute. Includes `<input>` and `<textarea>` elements.
public protocol HasReadonly {}

extension Tag.Input: HasReadonly {}
extension Tag.Textarea: HasReadonly {}

extension Attribute where Element: HasReadonly {
  /// Whether to allow the value to be edited by the user.
  ///
  /// - Parameter value: Whether to allow the value to be edited by the user.
  public static func readonly(_ value: Bool) -> Attribute {
    return .init("readonly", value ? "" : nil)
  }
}

/// Conforming elements can have a `rel` attribute. Includes `<a>`, `<area>`, and `<link>` elements.
public protocol HasRel {}

extension Tag.A: HasRel {}
extension Tag.Area: HasRel {}
extension Tag.Link: HasRel {}

extension Attribute where Element: HasRel {
  public struct Rel: RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
    }

    public static var alternate: Rel { return Rel(rawValue: "alternate") }
    public static var author: Rel { return Rel(rawValue: "author") }
    public static var bookmark: Rel { return Rel(rawValue: "bookmark") }
    public static var help: Rel { return Rel(rawValue: "help") }
    public static var icon: Rel { return Rel(rawValue: "icon") }
    public static var license: Rel { return Rel(rawValue: "license") }
    public static var next: Rel { return Rel(rawValue: "next") }
    public static var nofollow: Rel { return Rel(rawValue: "nofollow") }
    public static var prev: Rel { return Rel(rawValue: "prev") }
    public static var search: Rel { return Rel(rawValue: "search") }
    public static var stylesheet: Rel { return Rel(rawValue: "stylesheet") }
    public static var tag: Rel { return Rel(rawValue: "tag") }
  }

  public static func rel(_ value: Rel) -> Attribute {
    return .init("rel", value.rawValue)
  }
}

/// Conforming elements can have a `required` attribute. Includes `<input>`, `<select>` and `<textarea>` elements.
public protocol HasRequired {}

extension Tag.Input: HasRequired {}
extension Tag.Select: HasRequired {}
extension Tag.Textarea: HasRequired {}

extension Attribute where Element: HasRequired {
  /// Whether the control is required for form submission.
  ///
  /// - Parameter value: Whether the control is required for form submission.
  public static func required(_ value: Bool) -> Attribute {
    return .init("required", value ? "" : nil)
  }
}

/// Conforming elements can have a `rowspan` attribute. Includes `<td>` and `<th>` elements.
public protocol HasRowspan {}

extension Tag.Td: HasRowspan {}
extension Tag.Th: HasRowspan {}

extension Attribute where Element: HasRowspan {
  /// /// Number of rows that the cell is to span.
  ///
  /// - Parameter value: Number of rows that the cell is to span.
  public static func rowspan(_ value: Int) -> Attribute {
    return .init("rowspan", String(value))
  }
}

/// Conforming elements can have a `span` attribute. Includes `<col>` and `<colgroup>` elements.
public protocol HasSpan {}

extension Tag.Col: HasSpan {}
extension Tag.Colgroup: HasSpan {}

extension Attribute where Element: HasSpan {
  public static func span(_ value: Int) -> Attribute {
    return .init("span", String(value))
  }
}

/// Conforming elements can have a `src` attribute. Includes `<audio>`, `<embed>`, `<iframe>`, `<img>`, `<input>`, `<script>`, `<source>`, `<track>`, and `<video>` elements.
public protocol HasSrc {}

extension Tag.Audio: HasSrc {}
extension Tag.Embed: HasSrc {}
extension Tag.Iframe: HasSrc {}
extension Tag.Img: HasSrc {}
extension Tag.Input: HasSrc {}
extension Tag.Script: HasSrc {}
extension Tag.Source: HasSrc {}
extension Tag.Track: HasSrc {}
extension Tag.Video: HasSrc {}

extension Attribute where Element: HasSrc {
  /// Address of the resource.
  ///
  /// - Parameter value: Address of the resource.
  public static func src(_ value: String) -> Attribute {
    return .init("src", value)
  }
}

/// Conforming elements can have a `srcset` attribute. Includes `<img>` and `<source>` elements.
public protocol HasSrcset {}

extension Tag.Img: HasSrcset {}
extension Tag.Source: HasSrcset {}

extension Attribute where Element: HasSrcset {
  public enum Size: CustomStringConvertible {
    case w(Int)
    case x(Int)

    public var description: String {
      switch self {
      case let .w(n):
        return "\(n)w"
      case let .x(n):
        return "\(n)x"
      }
    }
  }

  /// Images to use in different situations (e.g., high-resolution displays, small monitors, etc).
  ///
  /// - Parameter value: Images to use in different situations (e.g., high-resolution displays, small monitors, etc).
  public static func srcset(_ value: [String: Size]) -> Attribute {
    return .init("srcset", value.map { url, size in url + " " + size.description }.joined(separator: ", "))
  }
}

/// Conforming elements can have a `target` attribute. Includes `<a>`, `<area>`, `<base>`, and `<form>` elements.
public protocol HasTarget {}

extension Tag.A: HasTarget {}
extension Tag.Area: HasTarget {}
extension Tag.Base: HasTarget {}
extension Tag.Form: HasTarget {}

extension Attribute where Element: HasTarget {
  /// Default browsing context for hyperlink navigation and form submission.
  public struct Target: RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
    }

    public static var blank: Target { return Target(rawValue: "_blank") }
    public static var `self`: Target { return Target(rawValue: "") }
    public static var parent: Target { return Target(rawValue: "_parent") }
    public static var top: Target { return Target(rawValue: "_top") }
  }

  /// Default browsing context for hyperlink navigation and form submission.
  ///
  /// - Parameter value: Default browsing context for hyperlink navigation and form submission.
  public static func target(_ value: Target) -> Attribute {
    return .init("target", value == .self ? nil : value.rawValue)
  }
}

/// Conforming elements can have a media `type` attribute. Includes `<embed>`, `<link>`, `<object>`, `<script>`, `<source>`, and `<style>` elements.
public protocol HasMediaType {}

extension Tag.A: HasMediaType {}
extension Tag.Embed: HasMediaType {}
extension Tag.Link: HasMediaType {}
extension Tag.Object: HasMediaType {}
extension Tag.Script: HasMediaType {}
extension Tag.Source: HasMediaType {}
extension Tag.Style: HasMediaType {}

extension Attribute where Element: HasMediaType {
  /// Hint for the type of the referenced resource.
  ///
  /// - Parameter value: Hint for the type of the referenced resource.
  public static func type(_ value: MediaType) -> Attribute {
    return .init("type", value.description)
  }
}

/// Conforming elements can have a `Double`-based `value` attribute. Includes `<input>`, `<meter>`, and `<progress>` elements.
public protocol HasDoubleValue {}

extension Tag.Input: HasDoubleValue {}
extension Tag.Meter: HasDoubleValue {}
extension Tag.Progress: HasDoubleValue {}

extension Attribute where Element: HasDoubleValue {
  public static func value(_ value: Double) -> Attribute {
    return .init("value", String(value))
  }
}

/// Conforming elements can have an `Int`-based `value` attribute. Includes `<input>` and `<li>` elements.
public protocol HasIntValue {}

extension Tag.Input: HasIntValue {}
extension Tag.Li: HasIntValue {}

extension Attribute where Element: HasIntValue {
  /// The form control's value. (Or, for `<li>` elements, the ordinal value of the list item.)
  ///
  /// - Parameter value: The form control's value.
  public static func value(_ value: Int) -> Attribute {
    return .init("value", String(value))
  }
}

/// Conforming elements can have a `String`-based `value` attribute. Includes `<button>`, `<input>`, and `<option>` elements.
public protocol HasStringValue {}

extension Tag.Button: HasStringValue {}
extension Tag.Input: HasStringValue {}
extension Tag.Option: HasStringValue {}

extension Attribute where Element: HasStringValue {
  /// The form control's value.
  ///
  /// - Parameter value: The form control's value.
  public static func value(_ value: String) -> Attribute {
    return .init("value", value)
  }
}

/// Conforming elements can have a media `type` attribute. Includes `<canvas>`, `<embed>`, `<iframe>`, `<img>`, `<input>`, `<object>`, `<svg>`, and `<video>` elements.
public protocol HasWidth {}

extension Tag.Canvas: HasWidth {}
extension Tag.Embed: HasWidth {}
extension Tag.Iframe: HasWidth {}
extension Tag.Img: HasWidth {}
extension Tag.Input: HasWidth {}
extension Tag.Object: HasWidth {}
extension Tag.Svg: HasWidth {}
extension Tag.Video: HasWidth {}

extension Attribute where Element: HasWidth {
  /// Horizontal dimension.
  ///
  /// - Parameter value: Vertical dimension.
  public static func width(_ value: Int) -> Attribute {
    return .init("width", String(value))
  }
}
