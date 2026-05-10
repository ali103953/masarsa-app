# نشر MASARSA إلى TestFlight

هذا المشروع أصبح مجهزًا محليًا للبناء عبر Codemagic، لكن الوصول إلى TestFlight يحتاج صلاحيات خارجية لا يمكن حفظها داخل الكود.

## 1. رفع التغييرات إلى GitHub

الـ commit الجاهز:

```bash
c6bfb09 Prepare MASARSA iOS production build
```

ادخل GitHub بحساب لديه صلاحية كتابة على:

```text
ali103953/masarsa-app
```

ثم نفذ:

```bash
git push origin main
```

إذا لم تستطع الدفع، أعط الحساب `tlana202320-commits` صلاحية `Write` على الريبو من:

```text
Repository Settings > Collaborators
```

## 2. إعداد App Store Connect

أنشئ تطبيق iOS جديد بهذه البيانات:

```text
App Name: MASARSA / مسارسا
Bundle ID: online.masarsa.app
SKU: masarsa-ios
Primary Language: Arabic
```

بعد إنشاء التطبيق، انسخ Apple ID الخاص بالتطبيق وضعه في:

```yaml
APP_STORE_APPLE_ID: ""
```

داخل `codemagic.yaml`.

## 3. إعداد Codemagic Secrets

في Codemagic افتح:

```text
Teams > Personal Account > Environment variables > apple
```

وأضف:

```text
APP_STORE_CONNECT_PRIVATE_KEY
APP_STORE_CONNECT_KEY_IDENTIFIER
APP_STORE_CONNECT_ISSUER_ID
```

هذه القيم تأتي من:

```text
App Store Connect > Users and Access > Integrations > App Store Connect API
```

## 4. تشغيل البناء

في Codemagic:

```text
Applications > masarsa-app > Start new build > ios-testflight
```

إذا نجح البناء، سيقوم Codemagic برفع ملف IPA إلى TestFlight تلقائيًا.

## 5. بعد ظهور build في TestFlight

- اختبر التطبيق على iPhone حقيقي.
- تحقق من فتح `https://masarsa.online/`.
- تحقق من العربية واتجاه RTL.
- تحقق من شاشة الخطأ عند إيقاف الإنترنت.
- استبدل الأيقونة المبدئية بأيقونة MASARSA الرسمية قبل الإصدار العام.

## ملفات احتياطية

تم تجهيز:

```text
masarsa-app-ready-for-testflight.zip
masarsa-testflight-ready.bundle
0001-Prepare-MASARSA-iOS-production-build.patch
```

استخدمها فقط إذا تعذر الدفع المباشر إلى GitHub.
