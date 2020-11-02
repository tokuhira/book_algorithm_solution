(defconstant +MAX+ 100000) ;; スタック配列の最大サイズ 

(defparameter *st* (make-array +MAX+)) ;; スタックを表す配列
(defparameter *top* 0) ;; スタックの先頭を表す添字

;; スタックを初期化する
(defun init ()
  (setf *top* 0)) ;; スタックの添字を初期位置に

;; スタックが空かどうかを判定する
(defun isEmpty ()
  (= *top* 0)) ;; スタックサイズが 0 かどうか

;; スタックが満杯かどうかを判定する
(defun isFull ()
  (= *top* +MAX+)) ;; スタックサイズが MAX かどうか

;; push
(defun my-push (x)
  (cond
    ((isFull)
     (format t "error: stack is full.~%"))
    (t
     (setf (aref *st* *top*) x) ;; x を格納して
     (incf *top*)))) ;; top を進める

;; pop
(defun my-pop ()
  (cond
    ((isEmpty)
     (format t "error: stack is empty.~%")
     -1)
    (t
     (decf *top*) ;; top をデクリメントして
     (aref *st* *top*)))) ;; top の位置にある要素を返す

(defun main ()
  (init) ;; スタックを初期化

  (my-push 3) ;; スタックに 3 を挿入する {} -> {3}
  (my-push 5) ;; スタックに 5 を挿入する {3} -> {3, 5}
  (my-push 7) ;; スタックに 7 を挿入する {3, 5} -> {3, 5, 7}

  (format t "~S~%" (my-pop)) ;; {3, 5, 7} -> {3, 5} で 7 を出力
  (format t "~S~%" (my-pop)) ;; {3, 5} -> {3} で 5 を出力

  (my-push 9)) ;; 新たに 9 を挿入する {3} -> {3, 9}

(main)
