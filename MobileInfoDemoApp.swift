import SwiftUI
import UIKit

@main
struct MobileInfoDemoApp: App {
    var body: some Scene {
        WindowGroup { DeviceInfoView() }
    }
}

struct DeviceInfoView: View {
    private let device = UIDevice.current
    @State private var copied = false

    private var details: [(String, String)] {
        [
            ("Tên thiết bị", device.name),
            ("Model thiết bị", device.model),
            ("Hệ điều hành", device.systemName),
            ("Phiên bản iOS", device.systemVersion),
            ("Giao diện", UIDevice.current.userInterfaceIdiom == .phone ? "iPhone" : "iPad/khác")
        ]
    }

    private var exportText: String {
        details.map { "\($0.0): \($0.1)" }.joined(separator: "\n")
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Image(systemName: "iphone.gen3")
                            .font(.system(size: 38, weight: .medium))
                            .foregroundStyle(.tint)
                        Text("Mobile Info")
                            .font(.title.bold())
                        Text("Thông tin thiết bị của bạn")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Section("Thông tin thiết bị") {
                    ForEach(details, id: \.0) { item in
                        HStack(alignment: .top, spacing: 16) {
                            Text(item.0)
                            Spacer(minLength: 12)
                            Text(item.1)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                                .textSelection(.enabled)
                        }
                        .padding(.vertical, 3)
                    }
                }
                Section {
                    Button {
                        UIPasteboard.general.string = exportText
                        copied = true
                    } label: {
                        Label(copied ? "Đã sao chép thông tin" : "Sao chép thông tin", systemImage: copied ? "checkmark.circle.fill" : "doc.on.doc")
                    }
                }
                Section("Giới hạn truy cập") {
                    Label("Chỉ dùng API UIKit công khai", systemImage: "checkmark.shield")
                        .font(.subheadline)
                    Text("Ứng dụng không truy cập MobileGestalt nội bộ, không đọc dữ liệu riêng tư và không vượt qua cơ chế bảo vệ của iOS.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Mobile Info")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
