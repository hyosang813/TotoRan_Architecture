## はじめに
- このリポジトリはtoto予想支援ツール[TotoRan](http://iphone.ascii.jp/2015/10/07/843459358653/)の簡易機能版を `MVP + CleanArchitecture` に則って書き直してみたものです。

## 全体感の説明
### DI
- UseCaseはinit時に必要なRepositoryを渡して作成
- Presenterはinit時に必要なUseCaseを渡して作成
- PresenterBuilderをDIコンテナとして用意

### 外部データソースへのアクセス部分
- 各外部サイトと通信するDataSourceを用意
- Repositoryは各DataSourceを取りまとめて抽象化
- 取得したデータはMapper(ACL)を介してModelに変換

### ディレクトリ構成
#### App層
![image](https://user-images.githubusercontent.com/11004583/121118100-3d870900-c854-11eb-9640-1fbb75c89749.png)

#### Domain層
![image](https://user-images.githubusercontent.com/11004583/121118173-5d1e3180-c854-11eb-8818-32f0e1a5b4f0.png)

#### Infra層
![image](https://user-images.githubusercontent.com/11004583/121118186-63aca900-c854-11eb-8bad-fd1175ba224c.png)

## 各画面の説明
### 起動直後画面
- 対象の回情報を下部に表示
- マルチ選択ボタンタップでマルチ選択画面に遷移
- データ再取得ボタンタップでデータリフレッシュ
- 支持率確認ボタンタップで支持率確認画面に遷移
#### 簡易的なクラス図
![image](https://user-images.githubusercontent.com/11004583/121109824-3c9baa80-c847-11eb-8749-f186b7428e45.png)

### 支持率確認画面
- 各13枠それぞれのホーム勝ち、アウェイ勝ち、引き分けの支持率確認画面
- totoはtotoの売れ具合を表示、bookはBookMakerの支持率を表示
- 閉じるボタンで起動直後画面に戻る
#### 簡易的なクラス図
![image](https://user-images.githubusercontent.com/11004583/121110105-b03db780-c847-11eb-88de-7ed97e157c9e.png)

### 予想選択画面
- 各13枠それぞれのホーム勝ち、アウェイ勝ち、引き分けの予想を選択する画面
- クリアボタンタップで選択状態を全解除
- 次へボタンタップで組み合わせ選択画面に遷移
- 戻るボタンタップで起動直後画面に戻る
#### 簡易的なクラス図
![image](https://user-images.githubusercontent.com/11004583/121110495-5a1d4400-c848-11eb-81a0-3ddc5d70b230.png)

### 組み合わせ選択画面
- ダブル、トリプルの数を選択できる画面
- 予想選択画面で選択したダブル、トリプルの数を下回る数は選択できない仕様
- 次へボタンタップで結果表示画面に遷移
- 戻るボタンタップで予想選択画面に戻る
※ 単純な画面なのでViewControllerのみで構成

### 結果表示画面
- totoのマルチに対応する結果表示画面
- 選択してない部分はランダムロジックに従って結果を表示
- 判定ボタンタップで判定表示画面に遷移
- 閉じるボタンタップで組み合わせ選択画面に戻る
#### 簡易的なクラス図
![image](https://user-images.githubusercontent.com/11004583/120975560-55a34d80-c7ac-11eb-972c-025cedce39f7.png)

### 判定表示画面
- 各組み合わせが支持率に対してどれだけの信頼度があるかを判定する画面
- 閉じるボタンタップで結果表示画面に戻る
#### 簡易的なクラス図
![image](https://user-images.githubusercontent.com/11004583/121110780-d0ba4180-c848-11eb-896b-ddd2df38b0a4.png)

## 出来てないけど今後やりたいと思ってること
- ~EmbeddedFrameWorkによるモジュール化~
    - ~AppとDomainとInfraの三層分割~
    - ~ディレクトリ構成は分割されてるのでおそらくそんなに難しくない？~
    - [やってみた](https://github.com/hyosang813/TotoRan_Architecture/pull/4)
- ~RxSwiftをCombineに置き換え~
    - ~RxSwiftの方が慣れていたので~
    - ~SwiftUIに置き換えるなら同時に相性が良い(はず)のCombineに置き換えたい~
    - [やってみた](https://github.com/hyosang813/TotoRan_Architecture/pull/5)
- UnitTest書く
    - アーキテクチャはTestableなコードを書くためのものでもあるのでちゃんと書いてく
- SwiftUIよる画面リッチ化
    - とりあえずアーキテクチャに主眼を置いたのでUIは簡素の極み
    - View部分はSwiftUIでちゃんと作りたい
- MVVMやVIPERへの移行
    - SwiftUI + CombineにするならMVVM導入はマスト？？？
- 番外編
    - 直接各サイトにアクセスしてローカルでParseしてるので、独自サーバを立ててサーバ側でスクレイピングしたデータをjsonAPIなどでやり取りするようにする
