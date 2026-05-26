# discourse-sentry

Discourse のバックエンド/Sidekiq エラーを **Sentry / GlitchTip** に転送する軽量プラグイン。

## 使い方

`containers/app.yml` の `hooks.after_code` にこのリポジトリのクローンを追加し、`env` に DSN を設定する:

```yaml
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - git clone https://github.com/stayhomeairlines/discourse-sentry.git

env:
  DISCOURSE_SENTRY_DSN: 'https://<public_key>@glitchtip.example.com/<project_id>'
  DISCOURSE_SENTRY_ENVIRONMENT: production
```

`./launcher rebuild app` で適用。

## 環境変数

| Name | Required | Description |
|------|----------|-------------|
| `DISCOURSE_SENTRY_DSN` | ○ | Sentry/GlitchTip の DSN。空または未設定なら無効。 |
| `DISCOURSE_SENTRY_ENVIRONMENT` | - | 環境タグ（既定 `Rails.env`）。 |

## 依存

- `sentry-ruby` `6.5.0`
- `sentry-rails` `6.5.0`
- `sentry-sidekiq` `6.5.0`

> Discourse の plugin.rb `gem` ディレクティブはバージョン指定子（`~>` 等）を解釈できないため、**厳密版でピン**してください。

## License

MIT
