(defun my-gcd (m n)
  (if (= n 0)
      m
      (my-gcd n (mod m n))))

(defun main ()
  (format t "~S~%" (my-gcd 51 15))
  (format t "~S~%" (my-gcd 15 51)))

(main)

  
