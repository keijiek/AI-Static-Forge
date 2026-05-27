# 使い方

## プロジェクト概要

- AI による静的サイト制作を前提としたテンプレートです。
- vite + tailwindcss v4 + alpinejs を基本構成とします。
- HTML を中心としたマルチページ構成が可能です。
- 共通パーツは handlebars partials 化します。

## 前提

実行環境として次のいずれかを想定している。

- シェル
  - windows の git-bash
  - windows の wsl の ubuntu
- node LTS版がインストール済みであること

## ひな形作成のコマンド

下記のコマンドでひな形作成を行う。
ただし、事前に `cd` を使って、カレントディレクトリをこのプロジェクトルートに合わせておくこと。

```bash
bash setup.sh
```

※上記コマンドの実行後 setup.sh は削除可。コマンドは次。

```bash
rm setup.sh
```

---

## npm の解説

### npm i と node_modules と package.json

- `package.json` があるディレクトリで `npm i` コマンドを実行すると、`package.json` の `devDependencies` と `dependencies` の情報をもとに、node_modules ディレクトリにパッケージ群がインストールされる。

```bash
npm i
# i は install のエイリアス
```

- node_modules ディレクトリを削除しても、 package.json があれば、何度でも `npm i` で元に戻せる。 node_modules の容量は数十～数百メガにもなるため、開発をしない間は node_modules だけ削除しておくのがよい。

```bash
rm -rf node_modules
# -rf はディレクトリとその内部を削除するために必須の引数。再帰的かつ強制の意。
```

### npm i / npm i -D (パッケージ追加)

次のように新しいパッケージをインストールできる。インストールの対象となるパッケージの正確なパッケージ名は、パッケージの公式サイトや、[npmjs.com](https://www.npmjs.com/) で調べる必要がある。

```bash
npm i -D パッケージ名
npm i パッケージ名
```

使用例は次の通り。

```bash
# vite と tailwindcss と @tailwindcss/vite をインストール
npm i -D vite tailwindcss @tailwindcss/vite 
# alpinejs をインストール
npm i alpinejs
```

- `npm i -D` でインストールすると、開発用のパッケージと見なされ、`package.json` の `devDependencies` に登録される。
- `npm i` でインストールすると、本番での実行に必要なパッケージと見なされ、`dependencies` に登録される。本番環境において、本番環境用パッケージだけをインストールする用途のため、この分類があると言ってよい。例えば、Express などのサーバーサイドのプログラムを動かすものが該当する。

※今回のように、vite を使って、必要な全てのパッケージを静的ファイルにバンドルする用途では、実質的な違いは小さい。そのため、開発用テンプレートとしては、すべて `npm i -D` として扱っても大きな問題は起こりにくい。

### npm run dev (開発サーバー)

開発サーバーを立てるコマンド。

```bash
npm run dev
```

指定された [localhost:5173](http://localhost:5173/) などのURLを、ウェブブラウザで確認しながら開発するためのもの。
ソースコードに変更があったら、自動的にブラウザ上の表示が変わるため、F5キーなどで読み込む必要はない。

### npm run host

```bash
npm run host
```

おなじ wi-fi につながる他の端末から閲覧するための機能.

### npm run build (ビルド)

エントリーポイントを起点に、依存対象の全てが、`dist` ディレクトリ内にビルドされる。

#### dist の中身が完成品

ビルドの結果、dist 内に現れるファイル群は、公開ファイルの全てである。dist 直下を、そのままのディレクトリ構造で本番環境へアップロードして用いることができる。

#### dist は何度でも作れる

npm run build を実行すれば、何度でも dist ディレクトリはビルドされます。必要がなければ dist を削除しても問題はありません。

### エントリーポイント

npm run dev や npm run build で、vite が動くが、処理の起点となる「エントリーポイント」が必ず存在する。

このプロジェクトでは、dist や node_modules を除く html ファイル群が、vite.config.js の設定によってエントリーポイントとして扱われる。

エントリーポイントが import / 参照した js・css・画像・フォント等は、依存対象としてビルドに巻き込まれる。

エントリーポイントが読み込んだファイルは、依存対象としてビルドに巻き込まれる。また、その依存対象が読み込んだファイルも、連鎖してビルドに巻き込まれる。幾重にも依存対象の読み込みが無くなるまで連鎖が続く。

### import について

js ファイル内で `import` されたファイルは、vite によって依存対象として認識される。

例えば、次のディレクトリ構造のとき、app.js で、下記のように記述することで、依存先として指定することになる。

- src/
  - js/
    - app.js : import する側
    - swiper/
      - topHeroSwiper.js : import される側
    - alpine.

```bash
import "./swiper/topHeroSwiper.js";
```
