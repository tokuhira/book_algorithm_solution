(defun main ()
  (let ((a (make-array 10 :initial-contents '(4 3 12 7 11 1 9 8 14 6))))

    ;; 0 番目の要素を出力 (4)
    (format t "~S~%" (aref a 0))

    ;; 2 番目の要素を出力 (12)
    (format t "~S~%" (aref a 2))

    ;; 2 番目の要素を 5 に書き換える
    (setf (aref a 2) 5)

    ;;// 2 番目の要素を出力 (5)
    (format t "~S~%" (aref a 2))))

(main)
