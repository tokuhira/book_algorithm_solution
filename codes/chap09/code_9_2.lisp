(defconstant +MAX+ 100000) ;; キュー配列の最大サイズ 

(defparameter *qu* (make-array +MAX+)) ;; キューを表す配列
(defparameter *tail* 0) ;; キューの要素の挿入位置を表す変数
(defparameter *head* 0) ;; キューの要素の先頭位置を表す変数

;; キューを初期化する
(defun init ()
  (setf *tail* 0)
  (setf *head* 0))

;; キューが空かどうかを判定する
(defun isEmpty ()
  (= *head* *tail*))

;; キューが満杯かどうかを判定する
(defun isFull ()
  (= *head* (mod (1+ *tail*) +MAX+)))

;; enqueue
(defun enqueue (x)
  (cond ((isFull)
         (format t "error: queue is full.~%"))
	(t
	 (setf (aref *qu* *tail*) x)
	 (incf *tail*)
	 (if (= *tail* +MAX+)
	     (setf *tail* 0))))) ;; リングバッファの終端に来たら 0 に

;; dequeue
(defun dequeue ()
  (cond ((isEmpty)
         (format t "error: queue is empty.~%")
         -1)
	(t
	 (let ((res (aref *qu* *head*)))
	   (incf *head*)
	   (if (= *head* +MAX+)
	       (setf *head* 0)) ;; リングバッファの終端に来たら 0 に
	   res))))

(defun main ()
  (init) ;; キューを初期化

  (enqueue 3) ;; キューに 3 を挿入する {} -> {3}
  (enqueue 5) ;; キューに 5 を挿入する {3} -> {3, 5}
  (enqueue 7) ;; キューに 7 を挿入する {3, 5} -> {3, 5, 7}

  (format t "~S~%" (dequeue)) ;; {3, 5, 7} -> {5, 7} で 3 を出力
  (format t "~S~%" (dequeue)) ;; {5, 7} -> {7} で 5 を出力

  (enqueue 9)) ;; 新たに 9 を挿入する {7} -> {7, 9}

(main)
