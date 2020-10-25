(defparameter *N* 8)
(defparameter *a* #(3 5 8 10 14 17 21 39))

;; 目的の値 key の添字を返す (存在しない場合は -1)
(defun binary_search (key)
  (let ((left 0) ;; 配列 a の左端
	(right (1- (length *a*)))) ;; 配列 a の右端
    (loop with mid
       unless (>= right left)
       return -1
       do (setf mid (+ left (floor (/ (- right left) 2)))) ;; 区間の真ん中
       if (= (aref *a* mid) key)
       return mid
       if (> (aref *a* mid) key)
       do (setf right (1- mid))
       if (< (aref *a* mid) key)
       do (setf left (1+ mid)))))

(defun main ()
  ;(print *N* *error-output*)
  ;(print *a* *error-output*)
  ;(terpri *error-output*)

  (format t "~S~%" (binary_search 10)) ;; 3
  (format t "~S~%" (binary_search 3)) ;; 0
  (format t "~S~%" (binary_search 39)) ;; 7

  (format t "~S~%" (binary_search -100)) ;; -1
  (format t "~S~%" (binary_search 9)) ;; -1 
  (format t "~S~%" (binary_search 100))) ;; -1

(main)
