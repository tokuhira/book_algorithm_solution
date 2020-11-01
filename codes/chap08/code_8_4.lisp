;; 連結リストの各ノードを表す構造体
(defstruct Node
  (next nil) ;; 次がどのノードを指すか
  (name (string ""))) ;; ノードに付随している値

;; 番兵を表すノードをグローバル領域に置いておく
(defparameter *sentinel* nil)

;; 初期化
(defun init ()
  (setf *sentinel* (make-Node))
  (setf (Node-next *sentinel*) *sentinel*)) ;; 初期状態では自分自身を指すようにする

;; 連結リストを出力する
(defun printList ()
  (let ((cur (Node-next *sentinel*))) ;; 先頭から出発
    (loop
      (if (eq cur *sentinel*) (return))
      (format t "~S -> " (Node-name cur))
      (setf cur (Node-next cur))))
  (terpri))

;; ノード p の直後にノード v を挿入する
;; ノード p のデフォルト引数を nil としておく (本実装の場合は *sentinel*)
;; そのため insert(v) を呼び出す操作は，リストの先頭への挿入を表す
(defun insert (v &optional (p *sentinel*))
  (setf (Node-next v) (Node-next p))
  (setf (Node-next p) v))

(defun main ()
  ;; 初期化
  (init)

  ;; 作りたいノードの名前の一覧
  ;; 最後尾のノード (「山本」) から順に挿入することに注意
  (let ((names (make-array 6 :initial-contents '("yamamoto"
						 "watanabe"
						 "ito"
						 "takahashi"
						 "suzuki"
						 "sato"))))

    ;; 各ノードを生成して，連結リストの先頭に挿入していく
    (loop for i below (length names)
       ;; ノードを作成する
       do (let ((the-Node (make-Node :name (aref names i))))

            ;; 作成したノードを連結リストの先頭に挿入する
	    (insert the-Node)

            ;; 各ステップの連結リストの様子を出力する
            (format t "step ~S: " i)
            (printList)))))

(main)
