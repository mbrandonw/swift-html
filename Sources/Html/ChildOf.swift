public struct ChildOf<Element> {
  public let rawValue: Node
  public init(_ node: Node) {
    self.rawValue = node
  }
}

extension ChildOf {
  public static func fragment(_ children: [ChildOf]) -> ChildOf {
    return .init(.fragment(children.map { $0.rawValue }))
  }
}

extension ChildOf: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ChildOf...) {
    self = .fragment(elements)
  }
}

extension ChildOf {
  /// The `<script>` element allows authors to include dynamic script and data blocks in their documents. The element does not represent content for the user.
  ///
  /// - Parameter attributes: Attributes.
  public static func script(attributes: [Attribute<Tag.Script>]) -> ChildOf {
    return script(attributes: attributes, safe: "")
  }

  /// The `<script>` element allows authors to include dynamic script and data blocks in their documents. The element does not represent content for the user.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: JavaScript.
  public static func script(attributes: [Attribute<Tag.Script>] = [], safe content: StaticString) -> ChildOf {
    return .init(.script(attributes: attributes, safe: content))
  }

  /// The `<script>` element allows authors to include dynamic script and data blocks in their documents. The element does not represent content for the user.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: JavaScript.
  public static func script(attributes: [Attribute<Tag.Script>] = [], unsafe content: String = "") -> ChildOf {
    return .init(.script(attributes: attributes, unsafe: content))
  }

  public static func template(attributes: [Attribute<Tag.Template>] = [], _ content: Node...) -> ChildOf {
    return .init(.template(attributes: attributes, .fragment(content)))
  }
}

extension ChildOf where Element == Tag.Colgroup {
  /// If a `<col>` element has a parent and that is a `<colgroup>` element that itself has a parent that is a `<table>` element, then the `<col>` element represents one or more columns in the column group represented by that `<colgroup>`.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  public static func col(attributes: [Attribute<Tag.Col>] = []) -> ChildOf<Tag.Colgroup> {
    return .init(.element("col", attributes: attributes, []))
  }
}

extension ChildOf where Element == Tag.Details {
  /// The first `<summary>` child element of a `<details>` element represents a summary, caption, or legend for the rest of the contents of the parent `<details>` element, if any.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func summary(attributes: [Attribute<Tag.Summary>] = [], _ content: Node...) -> ChildOf {
    return .init(.element("summary", attributes: attributes, .fragment(content)))
  }
}

extension ChildOf where Element == Tag.Dl {
  /// The `<dd>` element represents a description, part of a term-description group in a description list (`<dl>` element).
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func dd(attributes: [Attribute<Tag.Dd>] = [], _ content: Node...) -> ChildOf {
    return .init(.element("dd", attributes: attributes, .fragment(content)))
  }

  /// The `<dt>` element represents a term, part of a term-description group in a description list (`<dl>` element).
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func dt(attributes: [Attribute<Tag.Dt>] = [], _ content: Node...) -> ChildOf {
    return .init(.element("dt", attributes: attributes, .fragment(content)))
  }
}

extension ChildOf where Element == Tag.Fieldset {
  /// The `<legend>` element represents a caption for the rest of the contents of the `<legend>` element's parent `<fieldset>` element, if any.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func legend(attributes: [Attribute<Tag.Legend>] = [], _ content: Node...) -> ChildOf {
    return .init(.element("legend", attributes: attributes, .fragment(content)))
  }
}

extension ChildOf where Element == Tag.Figure {
  /// The `<figcaption>` element represents a caption or legend for the rest of the contents of the `<figcaption>` element's parent `<figure>` element, if any.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func figcaption(attributes: [Attribute<Tag.Figcaption>] = [], _ content: Node...) -> ChildOf {
    return .init(.element("figcaption", attributes: attributes, .fragment(content)))
  }
}

public enum Viewport {
  case fit(Fit)
  case height(Height)
  case initialScale(Double)
  case maximumScale(Double)
  case minimumScale(Double)
  case userScalable(Bool)
  case width(Width)

  public enum Height: ExpressibleByIntegerLiteral {
    case deviceHeight
    case px(Int)

    public var rawValue: String {
      switch self {
      case .deviceHeight:
        return "device-height"
      case let .px(px):
        return "\(px)"
      }
    }

    public init(integerLiteral value: Int) {
      self = .px(value)
    }
  }

  public enum Width {
    case deviceWidth
    case px(Int)

    public var rawValue: String {
      switch self {
      case .deviceWidth:
        return "device-width"
      case let .px(px):
        return "\(px)"
      }
    }

    public init(integerLiteral value: Int) {
      self = .px(value)
    }
  }

  public enum Fit: String {
    case auto
    case contain
    case cover
  }

  public var rawValue: String {
    switch self {
    case let .fit(fit):
      return "viewport-fit=" + fit.rawValue
    case let .height(px):
      return "height=" + px.rawValue
    case let .initialScale(scale):
      return "initial-scale=\(scale)"
    case let .maximumScale(scale):
      return "maximum-scale=\(scale)"
    case let .minimumScale(scale):
      return "minimum-scale=\(scale)"
    case let .userScalable(isUserScalable):
      return "user-scalable=\(isUserScalable ? "yes" : "no")"
    case let .width(px):
      return "width=" + px.rawValue
    }
  }
}

extension ChildOf where Element == Tag.Head {
  /// The `<base>` element allows authors to specify the document base URL for the purposes of parsing URLs, and the name of the default browsing context for the purposes of following hyperlinks. The element does not represent any content beyond this information.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  public static func base(attributes: [Attribute<Tag.Base>] = []) -> ChildOf {
    return .init(.element("base", attributes: attributes, []))
  }

  /// The `<link>` element allows authors to link their document to other resources.
  ///
  /// - Parameter attributes: Attributes.
  public static func link(attributes: [Attribute<Tag.Link>] = []) -> ChildOf {
    return .init(.element("link", attributes: attributes, []))
  }

  public static func meta(attributes: [Attribute<Tag.Meta>] = []) -> ChildOf {
    return .init(.element("meta", attributes: attributes, []))
  }

  public static func meta(contentType: MediaType) -> ChildOf {
    return meta(attributes: [.init("http-equiv", "content-type"), .content(contentType.description)])
  }

  public static func meta(defaultStyle: String) -> ChildOf {
    return meta(attributes: [.init("http-equiv", "default-stype"), .content(defaultStyle)])
  }

  public static func meta(refresh: Int) -> ChildOf {
    return meta(attributes: [.init("http-equiv", "refresh"), .content(String(refresh))])
  }

  public static func meta(applicationName: String) -> ChildOf {
    return meta(attributes: [.init("name", "application-name"), .content(applicationName)])
  }

  public static func meta(author: String) -> ChildOf {
    return meta(attributes: [.init("name", "author"), .content(author)])
  }

  public static func meta(description: String) -> ChildOf {
    return meta(attributes: [.init("name", "description"), .content(description)])
  }

  public static func meta(generator: String) -> ChildOf {
    return meta(attributes: [.init("name", "generator"), .content(generator)])
  }

  public static func meta(keywords: [String]) -> ChildOf {
    let sanitizedKeywords = keywords.map { $0.replacingOccurrences(of: ",", with: "&#44;") }
    return meta(attributes: [.init("name", "keywords"), .content(sanitizedKeywords.joined(separator: ","))])
  }

  public static func meta(name: String, content: String) -> ChildOf {
    return meta(attributes: [.init("name", name), .content(content)])
  }

  public static func meta(property: String, content: String) -> ChildOf {
    return meta(attributes: [.init("property", property), .content(content)])
  }

  public static func meta(viewport prop: Viewport, _ props: Viewport...) -> ChildOf {
    return meta(
      attributes: [
        .init("name", "viewport"),
        .content(([prop] + props).map { $0.rawValue }.joined(separator: ","))
      ]
    )
  }

  /// The `<style>` element allows authors to embed style information in their documents.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: A CSS string.
  public static func style(attributes: [Attribute<Tag.Style>] = [], safe content: StaticString) -> ChildOf {
    return style(attributes: attributes, unsafe: String(describing: content))
  }

  /// The `<style>` element allows authors to embed style information in their documents.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: A CSS string.
  public static func style(attributes: [Attribute<Tag.Style>] = [], unsafe content: String) -> ChildOf {
    return .init(.element("style", attributes: attributes, [.raw(escape(rawText: content, for: "style"))]))
  }

  /// The `<title>` element represents the document's title or name. Authors should use titles that identify their documents even when they are used out of context, for example in a user's history or bookmarks, or in search results. The document's title is often different from its first heading, since the first heading does not have to stand alone when taken out of context.
  ///
  /// - Parameter title: The document's title or name.
  public static func title(_ title: String) -> ChildOf {
    return .init(.element("title", [], [.raw(escape(rawText: title, for: "title"))]))
  }
}

extension ChildOf where Element == Tag.Html {
  /// The `<body>` element represents the content of the document.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func body(attributes: [Attribute<Tag.Body>] = [], _ content: Node...) -> ChildOf {
    return .init(.element("body", attributes: attributes, .fragment(content)))
  }

  /// The `<head> element represents a collection of metadata for the `Document`.
  ///
  /// - Parameter content: Child nodes.
  public static func head(_ content: ChildOf<Tag.Head>...) -> ChildOf {
    return .init(.element("head", [], ChildOf<Tag.Head>.fragment(content).rawValue))
  }
}

extension ChildOf where Element == Tag.Map {
  /// The `<area>` element represents either a hyperlink with some text and a corresponding area on an image
  /// map, or a dead area on an image map.
  public static func area(attributes: [Attribute<Tag.Area>] = []) -> ChildOf {
    return .init(.element("area", attributes: attributes, []))
  }
}

extension ChildOf where Element == Tag.Object {
  /// The `<param>` element defines parameters for plugins invoked by object elements. It does not represent
  /// anything on its own.
  ///
  /// - Parameters:
  ///   - name: Name of parameter.
  ///   - value: Value of parameter.
  public static func param(name: String, value: String) -> ChildOf {
    return .init(.element("param", [("name", name), ("value", value)], []))
  }
}

extension ChildOf where Element == Tag.Picture {
  public static func source(srcset: String, attributes: [Attribute<Tag.Source>] = []) -> ChildOf {
    return .init(.element("source", attributes: [.srcset(srcset)] + attributes, []))
  }
}

extension ChildOf where Element == Tag.Table {
  // TODO: "caption" can only be the first element of a "table"
  /// The `<caption>` element represents the title of the table that is its parent, if it has a parent and that is a table element.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func caption(attributes: [Attribute<Tag.Caption>] = [], _ content: Node...) -> ChildOf {
    return .init(.element("caption", attributes: attributes, .fragment(content)))
  }

  /// The `<colgroup>` element represents a group of one or more columns in the `table` that is its parent, if it has a parent and that is a `<table>` element.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func colgroup(attributes: [Attribute<Tag.Colgroup>] = [], _ content: ChildOf<Tag.Colgroup>...) -> ChildOf {
    return .init(.element("colgroup", attributes: attributes, ChildOf<Tag.Colgroup>.fragment(content).rawValue))
  }

  /// The `<tbody>` element represents a block of rows that consist of a body of data for the parent `<table>` element, if the `<tbody>` element has a parent and it is a `<table>`.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func tbody(attributes: [Attribute<Tag.Tbody>] = [], _ content: ChildOf<Tag.Tbody>...) -> ChildOf {
    return .init(.element("tbody", attributes: attributes, ChildOf<Tag.Tbody>.fragment(content).rawValue))
  }


  /// The `<tfoot>` element represents the block of rows that consist of the column summaries (footers) for the parent `<table>` element, if the `<tfoot>` element has a parent and it is a `<table>`.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func tfoot(attributes: [Attribute<Tag.Tfoot>] = [], _ content: Node...) -> ChildOf {
    return .init(.element("tfoot", attributes: attributes, .fragment(content)))
  }

  /// The `<thead>` element represents the block of rows that consist of the column labels (headers) for the parent `<table>` element, if the `<thead>` element has a parent and it is a `<table>`.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func thead(attributes: [Attribute<Tag.Thead>] = [], _ content: ChildOf<Tag.Thead>...) -> ChildOf {
    return .init(.element("thead", attributes: attributes, ChildOf<Tag.Thead>.fragment(content).rawValue))
  }
}

extension ChildOf where Element == Tag.Tr {
  /// The `<td>` element represents a data cell in a table.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func td(attributes: [Attribute<Tag.Td>] = [], _ content: Node...) -> ChildOf {
    return .init(.element("td", attributes: attributes, .fragment(content)))
  }

  // TODO: "th" can only be within "thead" or the first "tr" of a "table"
  /// The `<th>` element represents a header cell in a table.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func th(attributes: [Attribute<Tag.Th>] = [], _ content: Node...) -> ChildOf {
    return .init(.element("th", attributes: attributes, .fragment(content)))
  }
}

/// Conforming elements can contain `<li>` elements. Includes `<ol>` and `<ul>` elements.
public protocol ContainsLi {}

extension Tag.Ol: ContainsLi {}
extension Tag.Ul: ContainsLi {}

extension ChildOf where Element: ContainsLi {
  /// The `<li>` element represents a list item. If its parent element is an `<ol>`, or `<ul>`, then the element is an item of the parent element's list, as defined for those elements. Otherwise, the list item has no defined list-related relationship to any other `<li>` element.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func li(attributes: [Attribute<Tag.Li>] = [], _ content: Node...) -> ChildOf {
    return .init(.element("li", attributes: attributes, .fragment(content)))
  }
}

/// Conforming elements can contain `<option>` elements. Includes `<optgroup>` and `<select>` elements.
public protocol ContainsOption {}

extension Tag.Optgroup: ContainsOption {}
extension Tag.Select: ContainsOption {}

extension ChildOf where Element: ContainsOption {
  /// The `<option>` element represents an option in a `<select>` element or as part of a list of suggestions in a datalist element.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func option(attributes: [Attribute<Tag.Option>] = [], _ content: String) -> ChildOf {
    return .init(.element("option", attributes: attributes, [.text(content)]))
  }
}

/// Conforming elements can contain `<source>` elements. Includes `<audio>` and `<video>` elements.
public protocol ContainsSource {}

extension Tag.Audio: ContainsSource {}
extension Tag.Video: ContainsSource {}

extension ChildOf where Element: ContainsSource {
  public static func source(src: String, attributes: [Attribute<Tag.Source>] = [], _ transparent: Node...) -> ChildOf {
    return .init(.element("source", attributes: [.src(src)] + attributes, .fragment(transparent)))
  }
}

/// Conforming elements can contain `<tr>` elements. Includes `<table>`, `<tbody>` and `<thead>` elements.
public protocol ContainsTr {}

extension Tag.Table: ContainsTr {}
extension Tag.Tbody: ContainsTr {}
extension Tag.Thead: ContainsTr {}

extension ChildOf where Element: ContainsTr {
  /// The `<tr>` element represents a row of cells in a table.
  ///
  /// - Parameters:
  ///   - attributes: Attributes.
  ///   - content: Child nodes.
  public static func tr(attributes: [Attribute<Tag.Tr>] = [], _ content: ChildOf<Tag.Tr>...) -> ChildOf {
    return .init(.element("tr", attributes: attributes, ChildOf<Tag.Tr>.fragment(content).rawValue))
  }
}

/// Conforming elements can contain `<track>` elements. Includes `<audio>` and `<video>` elements.
public protocol ContainsTrack {}

extension Tag.Audio: ContainsTrack {}
extension Tag.Video: ContainsTrack {}

extension ChildOf where Element: ContainsTrack {
  /// The `<track>` element allows authors to specify explicit external text resources for media elements. It does not represent anything on its own.
  ///
  /// - Parameters:
  ///   - src: The `src` attribute gives the address of the text track data.
  ///   - attributes: Additional attributes.
  public static func track(src: String, attributes: [Attribute<Tag.Track>] = []) -> ChildOf {
    return .init(.element("track", attributes: [.src(src)] + attributes, []))
  }
}
