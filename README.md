# プロジェクトアーカイブ

このリポジトリは、ポートフォリオ用の「プロジェクトアーカイブ」と、制作物としての「ペットライフプラス」をまとめたものです。

- `index.html` からアーカイブのトップページを開けます
- `docs/` には企画書・仕様書・DB設計・テスト報告などの成果物があります
- `petlifeplus_site/` には、実際の制作物である **Pet Life Plus** のサイト本体があります

## 構成

### アーカイブ本体

- `index.html`, `about.html`, `works.html` などの紹介ページ
- `docs/` 企画・設計・テストのドキュメント
- `design/` 設計補足資料
- `prompts/` AI 支援用のプロンプト類
- `img/` 画像素材
- `css/`, `js/` アーカイブページ用の共通資産

### `petlifeplus_site/`

Pet Life Plus は、ペットの健康記録・相談・診療導線をまとめた Web アプリです。

- `frontend/` 静的な紹介サイト
- `backend/` Spring Boot + MyBatis + Thymeleaf の Web アプリ
- `docs/` 要件・DB設計・テスト報告など
- `scripts/` DB バックアップや補助スクリプト

## Pet Life Plus の概要

忙しい飼い主向けに、次の機能を提供するペット健康管理プラットフォームです。

- 健康記録の管理
- AI 症状チェック
- 診療予約
- カレンダー管理
- 通知・リマインド
- 獣医師向け診療記録
- Slack / LINE 連携
- Premium 向け Zoom オンライン診療

## ローカルでの確認方法

### 1. アーカイブページを見る

ブラウザで `index.html` を開けば、アーカイブのトップページを確認できます。

### 2. Pet Life Plus のフロントエンドを見る

`petlifeplus_site/frontend/public/index.html` をブラウザで開くか、静的サーバーで配信します。

### 3. バックエンドを起動する

`petlifeplus_site/backend/` で Maven Wrapper を使って起動します。

```bash
cd petlifeplus_site/backend
./mvnw spring-boot:run
```

Windows の場合:

```powershell
cd petlifeplus_site\backend
.\mvnw.cmd spring-boot:run
```

起動後は `http://localhost:8080` でアクセスできます。

## 必要環境

- Java 21
- Maven Wrapper での起動を推奨
- PostgreSQL

## 既定の接続情報

`petlifeplus_site/backend/src/main/resources/application.properties` の既定値は次の通りです。

- Host: `localhost`
- Port: `5432`
- Database: `petlifeplus`
- User: `postgres`
- Password: `hs0512`

## 主な環境変数

機能によっては、以下の環境変数を設定します。

- `OPENAI_API_KEY`
- `SLACK_BOT_TOKEN`
- `SLACK_SIGNING_SECRET`
- `LINE_CHANNEL_TOKEN`
- `LINE_CHANNEL_SECRET`
- `ZOOM_ACCOUNT_ID`
- `ZOOM_CLIENT_ID`
- `ZOOM_CLIENT_SECRET`
- `SENDGRID_API_KEY`
- `APP_BASE_URL`

## データベース初期化

このプロジェクトは、起動時の自動初期化を無効にしています。

- `spring.sql.init.mode=never`
- スキーマは `schema.sql`
- 初期データは `data.sql`

必要に応じて、バックアップ SQL の復元または `schema.sql` / `data.sql` の手動適用を行ってください。

## デフォルトアカウント

`DataInitializer` により、以下の初期アカウントが用意されています。

| Email | Password | Role |
|---|---|---|
| `admin@petlifeplus.local` | `admin123` | `ADMIN` |
| `owner1@petlifeplus.local` | `user123` | `USER` |
| `vet1@petlifeplus.local` | `vet123` | `VET` |
| `staff1@petlifeplus.local` | `staff123` | `STAFF` |
| `owner2@petlifeplus.local` | `user123` | `USER` |
| `owner.light@petlifeplus.local` | `light123` | `USER` |
| `owner.standard@petlifeplus.local` | `standard123` | `USER` |
| `owner.premium@petlifeplus.local` | `premium123` | `USER` |

## 参考ドキュメント

- [Pet Life Plus の概要](petlifeplus_site/petlife_plus.md)
- [フォルダ構成](petlifeplus_site/FOLDER_STRUCTURE.md)
- [バックエンド要件](petlifeplus_site/backend/docs/requirements.md)
- [DB 設計](petlifeplus_site/backend/docs/db-design.md)
- [テスト報告](petlifeplus_site/backend/docs/test_report.md)

## デプロイ

`petlifeplus_site/Dockerfile` と `render.yaml` を使ってデプロイできる構成です。

## 補足

- このリポジトリには、アーカイブ用の静的ページと、制作物としてのアプリ本体が含まれています
- バックエンドは Spring Security によるフォームログインを使います
- 外部連携は未設定でも、使わない機能には影響しないように設計されています
