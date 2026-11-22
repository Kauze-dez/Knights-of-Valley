# Valley of Knights

Браузерная RPG в одном файле (`index.html`), публикуется на Vercel как статический сайт.
Аккаунты: Supabase Auth (Google, Email + пароль, подтверждение почты, восстановление пароля).
Облачное сохранение прогресса: таблица `saves` с защитой Row Level Security (каждый видит только своё).

## Подключение аккаунтов (один раз)

1. **Supabase.** supabase.com → Sign in with GitHub → New project (название любое, регион ближайший, придумайте пароль базы) → дождитесь создания.
2. **База.** Слева SQL Editor → New query → вставьте весь файл `supabase-setup.sql` → Run.
3. **Ключи.** Project Settings → API: скопируйте *Project URL* и ключ *anon public*.
   Откройте `index.html` в GitHub (карандаш), найдите строку `var SUPA = { url: '', key: '' };`
   и вставьте значения в кавычки. Commit. (Ключ anon публичный — его можно хранить в коде, данные защищает RLS.)
4. **Адреса.** Authentication → URL Configuration:
   *Site URL* = ваша ссылка `https://название.vercel.app`; в *Redirect URLs* добавьте её же.
5. **Email.** Authentication → Providers → Email: «Confirm email» включён, «Secure email change» включён,
   минимальная длина пароля — 8. (Для боевого запуска настройте свой SMTP: Authentication → SMTP Settings;
   встроенная почта Supabase отправляет лишь несколько писем в час.)
6. **Google.**
   - console.cloud.google.com → создайте проект → APIs & Services → OAuth consent screen (External, название игры, ваша почта).
   - Credentials → Create credentials → OAuth client ID → тип Web application.
     В *Authorized redirect URIs* вставьте адрес из Supabase: Authentication → Providers → Google (строка «Callback URL», вида `https://xxxx.supabase.co/auth/v1/callback`).
   - Скопируйте Client ID и Client secret в Supabase → Authentication → Providers → Google → Enable → Save.
7. Откройте игру → «Вход и регистрация» и проверьте оба способа.

Пока ключи в `SUPA` пустые, игра работает как раньше (гость, прогресс в браузере).
