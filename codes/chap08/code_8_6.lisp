;; 連結リストの各ノードを表す構造体
(defstruct Node
  (prev nil) 
  (next nil)
  (name (string ""))) ;; ノードに付随している値

;; 番兵を表すノードをグローバル領域に置いておく
(defparameter *sentinel* nil)

;; 初期化
(defun init ()
  (setf *sentinel* (make-Node))
  (setf (Node-prev *sentinel*) *sentinel*)
  (setf (Node-next *sentinel*) *sentinel*))

;; 連結リストを出力する
(defun printList ()
  (let ((cur (Node-next *sentinel*))) ;; 先頭から出発
    (loop
      (if (eq cur *sentinel*) (return))
      (format t "~S -> " (Node-name cur))
      (setf cur (Node-next cur))))
  (terpri))

;; ノード p の直後にノード v を挿入する
(defun insert (v &optional (p *sentinel*))
  (setf (Node-next v) (Node-next p))
  (setf (Node-prev (Node-next p)) v)
  (setf (Node-next p) v)
  (setf (Node-prev v) p))

;; ノード v を削除する
(defun erase (v)
  (unless (eq v *sentinel*) ;; v が番兵の場合は何もしない
    (setf (Node-next (Node-prev v)) (Node-next v))
    (setf (Node-prev (Node-next v)) (Node-prev v))
    (setf v nil))) ;; メモリを開放?

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
						 "sato")))
	(watanabe))

    ;; 各ノードを生成して，連結リストの先頭に挿入していく
    (loop for i below (length names)
       ;; ノードを作成する
       do (let ((the-Node (make-Node :name (aref names i))))

            ;; 作成したノードを連結リストの先頭に挿入する
	    (insert the-Node)

            ;; 「渡辺」ノードを保持しておく
	    (if (equal (Node-name the-Node) "watanabe")
		(setf watanabe the-Node))))
    
    ;; 「渡辺」ノードを削除する
    (princ "before: ")
    (printList) ;; 削除前を出力
    (erase watanabe)
    (princ "after: ")
    (printList))) ;; 削除後を出力

(main)
