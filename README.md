# 写真管理アプリ（ツイート機能付き）

## 開発環境情報
- Ruby: 3.1.2
- Rails: 7.1.3.2
- DBはsqlite3を使用

## アプリ実行手順

#### DBセットアップ手順
- Migration実行コマンド
  - `bin/rails db:migrate`
- Seed実行コマンド
  - `bin/rails db:seed`  

#### アプリケーション起動手順
- サーバー起動コマンド
  - `bin/rails s`

#### アクセス手順
- アクセスURL
  - `http://localhost:3000`  
  ※アクセス後に/loginへリダイレクトされます。 
  ※アクセスできない場合はブラウザのcookieを削除してみてください。
- ログイン
  - Seedにて作成される以下の初期ユーザーでログイン可能です。  
  ```
  ユーザーID: user1  
  パスワード: password  
  ```
