# REMPI（レムピ）

![REMPI](https://i.gyazo.com/4aa9e3a817947de9d1b6a4b247458781.png)

## DEMO MOVIE
[![rempidemo](https://i.gyazo.com/4bbcc7633b73667848e09c6f2a37e192.png)](https://youtu.be/VrVtXWveN-w)

## 製品概要
### Cook × Tech

### 背景（製品開発のきっかけ、課題等）
最近、料理レシピ動画が「見たままに料理すればいいから簡単！」という理由で料理が苦手な人にも非常に人気です。

しかし、実際にレシピ動画を見ながら料理してみると、動画を参考にしながら料理をしなければいけないので同時に複数品目を作ることができません。料理の仕方としては、複数の品目について「食材を切る」や「火にかける」などを同時並行して効率よくこなすことが理想です。

また、料理が苦手な人が、その苦手な理由として「料理を効率よく同時並行で作業できなくて、トータルでかなり時間がかかってしまい疲れる」ということもインタビューを通してわかっています。

そこで今回、レシピ動画を参考にする場合でも効率よく同時並行で料理ができるようにならないかと考えました。

### 製品説明（具体的な製品の説明）
REMPI（レムピ）は、自分が作りたい料理を複数選択し、それら全てを作るために最適な手順を提示して、効率よくそして簡単に料理ができる「料理手順最適化レシピアプリ」です。

### 特長

#### 1. 各料理のレシピ動画について工程レベルで分割・ロジックを組み立て、マージして最適な手順を表示

![koutei](https://i.gyazo.com/4eafa81afe82f710896835d63395d96a.png)

選択した各料理について、レシピ動画を「食材を切る」「火にかける」といった工程に切り分けた状態でロジックを組み、一番効率の良い順番で再生されます。これにより、煮込んでいる隙間時間で他の料理の下ごしらえをするといったことが可能になり、時短につながります。

#### 2. 手が汚れたりふさがっていても音声認識による操作が可能

レシピ動画を見て実際に料理しているときに起きるちょっとした問題として、手が肉の油や小麦粉などで汚れているときにデバイスに触れないので動画を一旦止める等ができないことが挙げられます。これを解決するため、音声認識で再生や次の工程へのトリガーを与えることができるようにしました。

### 解決出来ること
料理が苦手な人がレシピ動画を見ながら作る際、より効率的に料理できるので悩みである「料理に時間がかかって疲れる」ことが解消されます。また、同時並行での料理の実践をさせてくれるので、同時並行で料理をするにはどう行動すればいいか実感を伴って学習していけます。

### 今後の展望
- iOS, Androidでのネイティブアプリ開発
- 「料理に対して工程レベルで分割・ロジック組み立て→マージして最適な手順を表示する」という機能に関しては、例えばチェーンレストランにおいて客からの注文に対してこの機能を応用すれば、初心者の調理師でも慌てることなく最適なオペレーションができるようになる、など汎用性が高く、toCでもtoBでもスケールできる


## 開発内容・開発技術
### 活用した技術
#### API・データ
今回スポンサーから提供されたAPI、製品などの外部技術があれば記述をして下さい。

* DELISH KITCHEN
* Google Cloud Vision API
* Google Speach API

#### フレームワーク・ライブラリ・モジュール
* Ruby on Rails
* OpenCV

### 独自開発技術（Hack Dayで開発したもの）
#### 2日間に開発した独自の機能・技術
* 解説テキストがはいった動画に対して、そのテキストを元にチャプターに分割する技術

動画の各フレームを分析してテキストが表示されている領域を抽出している。その区間の画素のヒストグラムを前後のフレームのヒストグラムと比較することでテキストが変化しているかをチェックしている。

(例：https://github.com/jphacks/TK_1713/blob/master/src/movie_processing/hist.ipynb)

そして、テキストが変化しているとみなされた場合のみOCRにかけ、実際にテキストが変化していた場合は、そこを動画の切れ目としてチャプターに分割している。

(https://github.com/jphacks/TK_1713/blob/master/src/movie_processing/devide.py)

* 並行調理スケジュール法の実装

並行調理スケジュール法のアルゴリズムは、[1]を参考にした。これに一部変更を加え、REMPIのデータセット・コンセプトに合うように工夫した。
アルゴリズムを次に示す．なおこのアルゴリズムは`src/tk_1713_parallize/Parallize.py`内に記述した．

具体的な変更点は，従来の論文ではコンロを1つしか使わないところを複数使えるようにした（プログラム内で変更可能）部分と，3つ以上の料理に対応させた部分である．

[1] 杉本　和香奈, 佐藤　哲司. "既存レシピを活用した並行調理スケジュール法の提案と評価", 電子情報通信学会技術研究報告. DE, データ工学. May, 2012.


```
WHILE 全ての料理が完成するまで
  時刻を1進める
  ForEach 完成していない料理
    特定の工程が終了しているか確認（工程の残り時間がゼロなら完了しているとみなす）
    IF 工程が終了
      IF コンロを使用していた
        使用可能コンロの数を1増やす
      IF 負荷のかかる作業
        ユーザの負荷をゼロにする
      調理終了を時間とともに記録
      この料理の工程番号を1進める
  
  ForEach 完成していない料理
    IF 調理中でなければ
      IF コンロが必要でコンロの空きがなければ
        continue
      IF 負荷のいる作業でユーザが負荷状態ならば
        continue
      調理中フラグを立てる
      IF コンロが必要
        コンロの空きを一つ減らす
      IF 負荷のいる作業
        ユーザの負荷状態フラグを立てる
      調理開始を時間とともに記録
  
  ForEach 調理中の料理
    現在の行っている工程の残り時間を1減らす
    
```

* 特に力を入れた部分をファイルリンク、またはcommit_idを記載してください（任意）

### コード概要
#### src/movie_processing
* devide.py

上で述べたように、画素のヒストグラムの相関やOCR結果を用いることで、textの切り替わりを判別しているプログラム。textの内容、出始め・出終わりの時間などの情報をcsvとして出力する。

* google_ocr.py

Google Vision APIを使ってOCRをしているプログラム。

* extract_text.py

OpenCVを使って、画像からtext領域を取得するプログラム。

* make_table.py

devide.pyで得た情報を元に、調理に必要な各工程に対して、調理内容、コンロを使うか、放置できるか、放置できる場合は何分放置できるか、を求め、csvとして出力するプログラム。

* hist.ipynb

画素のヒストグラムの相関からどの程度textの変化を推定できるかの実験例を示したプログラム。

#### src/tk_1713_parallize
* Dish.py

手順やレシピのクラスの実装

* Parallize.py

工程スケジューリングアルゴリズムの実装

* flask_test.py

上記の工程スケジューリングを行うサーバプログラム

`python flask_test.py`でサーバーが起動し，
`{"recipe_ids": [x, x, ...]}`という形式のjsonをpostすると
`{"result": [{"index": xxx, "description": xxx, "duration": xxx, "mo_start": xxx, "mo_end": xxx, "recipe_id": xxx}, ...]}`という形式のjsonが返ってくる
