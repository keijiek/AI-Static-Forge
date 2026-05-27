# 静的なhtmlサイトをAIで作成するプロジェクトのひな形

updated: 2026-05-27

## はじめに

- 日本語で対応してください。
- 不明点や疑問点は質問してください。

## プロジェクト概要

このプロジェクトは、Claude Code を使って、ウェブサイトをコーディングするためのものです。

## 使用言語

- html
- css
- js

## 技術スタック

下記のパッケージが、このプロジェクトに npm でインストール済みである。
他に必要だと考えるパッケージがあれば、提案せよ。その際は、まず提案のみを行い、インストール(npm i, npm i -D)は人間の確認を得て実行せよ。

### ウェブサイトのコーディングのために使うもの

- vite
- tailwindcss (v4)
- vite-plugin-handlebars
- alpinejs
- lucide
- swiper
- gsap

※なお、 gsap は、2025年4月末以降、Club Plugins も含めて無料で提供されている点に注意。

### vite.config.js で使用するもの

- @tailwindcss/vite
- fast-glob

## コーディング規約

- html を記述するときは、できるだけセマンティックなhtmlタグを使用せよ。
- css によるスタイリングは、原則として tailwindcss (v4) に依存せよ。
  - arbitrary values（`h-[72px]` のような [] を使った固定値指定）は原則使用しない。Tailwind のスケール内で代替できないか先に検討せよ。やむを得ず使う場合は、その理由をコメントで残せ。
- ウェブサイトのフロント側に js を使って実装する挙動は、原則として alpinejs に依存せよ。例えば、ドロワーメニュー機能などを alpinejs で実装することを意図している。
  - やむなく js の生のコードを書く時は、ECMA Script のやり方に従え。
- swiper や gsap や lucide などのパッケージを必要とする機能を作るときは、 src/js/swiper や src/js/gsap や src/js/lucide のように、対応するディレクトリの中に js ファイルを作成していくこと。対応するディレクトリが存在しない場合は、ディレクトリを作成せよ。それらの js ファイルを、 src/js/app.js から import して用いよ。

## breakpoint

- ウェブサイトのブレイクポイントとしては、tailwindcss のブレイクポイント(`md`, `lg`, `xl`)を利用せよ。

## handlebars の利用

- head 要素、header 要素、footer 要素、ドロワーメニューパネルの nav 要素など、複数ページ間で共有するパーツは、 vite-plugin-handlebars を使って作成し、 html ファイルから参照せよ。
- hbs ファイルは partials ディレクトリ内に作成せよ。
- 初期状態で、下記の hbs ファイルを作成済みなので、それを修正しながら用いよ。

### 初期の hbs ファイルリスト

- partials/head.hbs
- partials/header.hbs
- partials/footer.hbs

## ディレクトリ構造

このプロジェクトの、初期のディレクトリ構造は次の通り。

- root/
  - imgs/ : コーディングで必要になる画像を、私が準備して入れておく。
  - src/
    - css/
      - app.css
    - js/
      - app.js
      - gsap/ : gsap を使った機能ひとつごとに1ファイルを作成
      - lucide/
        - lucideIcons.js : Lucide のアイコン設定。ウェブサイトにアイコンを追加する場合、このファイル上で、そのアイコンを登録して用いよ。
      - swiper/ : swiper を使った機能ひとつにつき、1つの js ファイルを作成していく。
      - alpinejs/ : alpinejs のための js ファイルを入れる。
        - alpine.js
  - partials/
    - head.hbs
    - header.hbs
    - footer.hbs
  - index.html
  - package.json
  - package-lock.json
  - vite.config.js
