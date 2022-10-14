// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3bafbf"></span>
  /// Alpha: 100% <br/> (0x3bafbfff)
  internal static let blue = ColorName(rgbaValue: 0x3bafbfff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#8d939c"></span>
  /// Alpha: 100% <br/> (0x8d939cff)
  internal static let darkGray = ColorName(rgbaValue: 0x8d939cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#4caf50"></span>
  /// Alpha: 100% <br/> (0x4caf50ff)
  internal static let green = ColorName(rgbaValue: 0x4caf50ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#71e6f5"></span>
  /// Alpha: 100% <br/> (0x71e6f5ff)
  internal static let lightBlue = ColorName(rgbaValue: 0x71e6f5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e5e7e9"></span>
  /// Alpha: 100% <br/> (0xe5e7e9ff)
  internal static let lightGray = ColorName(rgbaValue: 0xe5e7e9ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f28b6b"></span>
  /// Alpha: 100% <br/> (0xf28b6bff)
  internal static let orange = ColorName(rgbaValue: 0xf28b6bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f34133"></span>
  /// Alpha: 100% <br/> (0xf34133ff)
  internal static let red = ColorName(rgbaValue: 0xf34133ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#333333"></span>
  /// Alpha: 100% <br/> (0x333333ff)
  internal static let softBlack = ColorName(rgbaValue: 0x333333ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f0fbfd"></span>
  /// Alpha: 100% <br/> (0xf0fbfdff)
  internal static let ultraLightBlue = ColorName(rgbaValue: 0xf0fbfdff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f3f6fa"></span>
  /// Alpha: 100% <br/> (0xf3f6faff)
  internal static let ultraLightGray = ColorName(rgbaValue: 0xf3f6faff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let components = RGBAComponents(rgbaValue: rgbaValue).normalized
    self.init(red: components[0], green: components[1], blue: components[2], alpha: components[3])
  }
}

private struct RGBAComponents {
  let rgbaValue: UInt32

  private var shifts: [UInt32] {
    [
      rgbaValue >> 24, // red
      rgbaValue >> 16, // green
      rgbaValue >> 8,  // blue
      rgbaValue        // alpha
    ]
  }

  private var components: [CGFloat] {
    shifts.map { CGFloat($0 & 0xff) }
  }

  var normalized: [CGFloat] {
    components.map { $0 / 255.0 }
  }
}

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
