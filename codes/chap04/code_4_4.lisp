(defun myGCD (m n)
  (if (= n 0)
      m
      (myGCD n (mod m n))))

(defun main ()
  (format t "~S~%" (myGCD 51 15))
  (format t "~S~%" (myGCD 15 51)))

(main)

  
