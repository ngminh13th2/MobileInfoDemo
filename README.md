# Mobile Info — iOS source package

Ứng dụng SwiftUI hiển thị thông tin thiết bị qua API UIKit công khai, có nút sao chép. Không dùng private API MobileGestalt.

## Cách tạo IPA bằng GitHub Actions (không cần bạn có Mac)

1. Tạo một repository GitHub mới và tải toàn bộ nội dung thư mục này lên (giữ nguyên thư mục `.github`).
2. Mở tab **Actions** và bật GitHub Actions nếu GitHub yêu cầu.
3. Chạy workflow **Build unsigned IPA** bằng nút **Run workflow**.
4. Khi workflow hoàn tất, mở phần **Artifacts** của lần chạy và tải `MobileInfoDemo-unsigned-ipa`.
5. Giải nén artifact; file `MobileInfoDemo.ipa` là bản **chưa ký**. Dùng KSign để ký bằng chứng chỉ/provisioning profile phù hợp với thiết bị của bạn.

Workflow dùng máy ảo macOS và Xcode của GitHub Actions để biên dịch. Bản unsigned không tự cài được trước khi ký. Việc ký thành công còn phụ thuộc chứng chỉ, provisioning profile và chính sách iOS hiện hành.

## Build thủ công trên Mac

Cần Mac có Xcode. Mở Terminal trong thư mục dự án và chạy:

```bash
xcodegen generate
xcodebuild -project MobileInfoDemo.xcodeproj -scheme MobileInfoDemo -configuration Release -sdk iphoneos -derivedDataPath build CODE_SIGNING_ALLOWED=NO build
mkdir -p Payload
cp -R build/Build/Products/Release-iphoneos/MobileInfoDemo.app Payload/
zip -r MobileInfoDemo.ipa Payload
```

## Giới hạn

Đây là ứng dụng xem thông tin thiết bị cơ bản, không phải công cụ đọc toàn bộ MobileGestalt. Không thể tạo IPA đã ký cho thiết bị cụ thể nếu không có quy trình build iOS và thông tin ký phù hợp.
