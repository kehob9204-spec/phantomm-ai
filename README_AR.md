# PHANTOM AI Platform — النسخة النهائية القابلة للنشر

هذه الحزمة تشغّل منصة Go واحدة تجمع:

- PHANTOM AI مع OpenRouter.
- دخول البريد/كلمة المرور.
- Google Identity Services الحقيقي عند ضبط Google Client ID.
- GitHub OAuth الحقيقي عند ضبط GitHub Client ID/Secret.
- ضيف للدردشة مع AI فقط.
- استعادة كلمة المرور عبر SMTP عند تفعيله.
- حساب مطور منفصل ولوحة إدارة وتوثيق.
- توثيق أحمر للمطور وأزرق للحسابات العادية، مع جدولة التوثيق بعد 10 ثوانٍ بأمر المطور.
- Feed فيديوهات عمودي، إعجاب، تعليق، متابعة، حفظ، إعادة نشر، مشاركة رابط، ملف شخصي، بحث، رسائل، إشعارات، أصدقاء ومجموعات.
- صلاحيات مالك المجموعة والمشرفين والحظر داخل المجموعة.
- مراجعة محتوى أساسية آلية للنصوص والمنشورات، ومراجعة إطار من الفيديو عند توفر FFmpeg.
- تخزين مشفر محلياً مع دعم snapshot خارجي عبر Supabase.
- واجهة إعدادات للمطور لحفظ مفتاح OpenRouter داخل مخزن المنصة المشفر بدلاً من وضعه في JavaScript.

## مهم جداً

لا يوجد تطبيق ويب يمكن ضمان أنه "بلا أي ثغرة". هذه النسخة تضيف طبقات دفاعية كثيرة، لكن يجب إجراء اختبار أمني مستقل قبل نشرها للعامة.

## تشغيل محلي

1. انسخ `phantom_config.json.example` إلى `phantom_config.json`.
2. ضع مفتاح OpenRouter في `openrouter_api_key` أو احفظه من إعدادات حساب المطور بعد تشغيل الموقع.
3. شغّل:

```bash
go run main.go
```

ثم افتح:

`http://localhost:8080`

## Google

أنشئ OAuth/Google Identity credential واضبط `google_client_id`. يجب أن يطابق النطاق/الأصل المستخدم في إعداد Google، وأن يبقى التحقق من ID token في الخادم.

## GitHub

اضبط:

- `GITHUB_CLIENT_ID`
- `GITHUB_CLIENT_SECRET`
- `PHANTOM_PUBLIC_URL`

والـcallback يكون:

`https://YOUR-DOMAIN/oauth/github/callback`

## التخزين الدائم

لأن نظام ملفات الخدمة السحابية قد لا يكون دائماً، استخدم Supabase للبيانات والوسائط المهمة. ضع:

- `SUPABASE_URL`
- `SUPABASE_SERVICE_ROLE_KEY`
- `SUPABASE_STATE_TABLE=phantom_state`
- `SUPABASE_MEDIA_BUCKET=phantom-media`

ولا تضع Service Role Key في JavaScript أو في مستودع Git عام.

## النشر الرسمي

ارفع المشروع إلى مستودع Git ثم اربطه بخدمة Web على Render باستخدام `render.yaml` أو Dockerfile. بعد نجاح النشر تحصل على رابط `onrender.com`. بعد ذلك يمكنك ربط نطاق تملكه وتضعه في `PHANTOM_PUBLIC_URL`، ثم تحدث callback URLs في Google/GitHub.

## ملاحظة عن الرابط الخارجي

الرابط الخارجي الحقيقي لا يمكن إنشاؤه من ملف Go وحده. يجب نشر التطبيق على خدمة استضافة أو سيرفر، ثم يصبح له عنوان عام. Cloudflare Quick Tunnel مناسب للتجربة، وليس بديلاً عن نطاق إنتاج دائم.
