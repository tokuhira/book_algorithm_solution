;; 連結リストの各ノードを表す構造体
(defstruct node
  (prev nil) 
  (next nil)
  (name (string ""))) ;; ノードに付随している値

;; 番兵を表すノードをグローバル領域に置いておく
(defparameter *sentinel* nil)

;; 初期化
(defun init ()
  (setf *sentinel* (make-node))
  (setf (node-prev *sentinel*) *sentinel*)
  (setf (node-next *sentinel*) *sentinel*))

;; 連結リストを出力する
(defun printList ()
  (let ((cur (node-next *sentinel*))) ;; 先頭から出発
    (loop
      (if (eq cur *sentinel*) (return))
      (format t "~S -> " (node-name cur))
      (setf cur (node-next cur))))
  (terpri))

;; ノード p の直後にノード v を挿入する
(defun insert (v &optional (p *sentinel*))
  (setf (node-next v) (node-next p))
  (setf (node-prev (node-next p)) v)
  (setf (node-next p) v)
  (setf (node-prev v) p))

;; ノード v を削除する
(defun erase (v)
  (unless (eq v *sentinel*) ;; v が番兵の場合は何もしない
    (setf (node-next (node-prev v)) (node-next v))
    (setf (node-prev (node-next v)) (node-prev v))
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
       do (let ((the-node (make-node :name (aref names i))))

            ;; 作成したノードを連結リストの先頭に挿入する
	    (insert the-node)

            ;; 「渡辺」ノードを保持しておく
	    (if (equal (node-name the-node) "watanabe")
		(setf watanabe the-node))))
    
    ;; 「渡辺」ノードを削除する
    (princ "before: ")
    (printList) ;; 削除前を出力
    (erase watanabe)
    (princ "after: ")
    (printList))) ;; 削除後を出力

(main)
