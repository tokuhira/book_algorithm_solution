(defparameter *N* 8)
(defparameter *a* #(3 5 8 10 14 17 21 39))

;; 目的の値 key の添字を返す (存在しない場合は -1)
(defun binary_search (key)
  (let ((left 0) ;; 配列 a の左端
	(right (1- (length *a*)))) ;; 配列 a の右端
    (do ((mid (+ left (floor (/ (- right left) 2)))   ;; init-form 区間の真ん中
	      (+ left (floor (/ (- right left) 2))))) ;; step-form 区間の真ん中
	((or (< right left)                           ;; end-test 1of2
	     (= (aref *a* mid) key))                  ;; end-test 2of2
	 (if (< right left)                           ;; result
	     -1                                       ;; result 1of2
	     mid))                                    ;; resutl 2of2
      (if (> (aref *a* mid) key)                      ;; body
	  (setf right (1- mid)))
      (if (< (aref *a* mid) key)
	  (setf left (1+ mid))))))

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
