# 概要

EmbulkとDigdagでETLを構築するためのプロジェクトテンプレートです。

以下を含みます。

* イメージビルド用のDockerfile
* ルールに基づいたEmbulkの拡張、設定用ディレクトリ
* ルールに基づいたDigdagの拡張、設定ディレクトリ

## 環境要件

* Java 8 -> EmbulkがまだJava 9に対応していないので、8系でお願いします。

### 環境変数

イメージには以下の環境変数を設定しています。ETL構築時には環境変数を利用して構築するように設計し、そのままビルドできるようにしてください。

| 環境変数名 | 意味 |
| ETL_APPS_ROOT | ETLアプリケーションの内容です。イメージビルド時にコピーされる `etl_apps` のパスとなります。 |
| EMBULK_APPS_ROOT | Embulkローダ設定のルートパスです。 `${ETL_APPS_ROOT}/embulk` となります。 |
| ETL_APPS_TARGET_ROOT | 実行に必要な中間ファイルを置くための場所です。 |
| EMBULK_APPS_TARGET | Embulkの中間ファイル格納場所です。 `${ETL_APPS_TARGET_ROOT}/embulk` となります。 |

## Embulkの実行について

### 実行ファイル

`etl_apps/embulk` 配下に `.yml` ファイルを格納します。イメージ作成時に実行環境にコピーされます。

### プラグインについて

`etl_apps/embulk/.bundle` にバンドル情報を格納してください。初期状態では作成されていませんので、 `embulk mkbundle etl_apps/embulk/.bundle` を実行してください。

## Digdagの実行について

### 実行ファイル

`etl_apps/digdag` 配下に `.dig` ファイルを格納します。イメージ作成時に実行環境にコピーされます。

## 出力先

### アウトプット

ファイルとして出力する場合などは `/usr/local/output` にホストの出力先をマウントして実行してください。ジョブの出力先指定漏れに注意してください。

### ログ等システム関連

各種ログなどは `/usr/local/system_info` に出力します。マウントポイントをイメージに設定していますので、必要に応じてマウントして実行してください。digdagは `--log` を付けて実行するようにしてください。

## 参考

Embulk(バルクデータローダ): http://www.embulk.org/docs/
Digdag(ワークフローエンジン): https://www.digdag.io/