(defun main ()
  ;; A さんの数の候補を表す区間を、[left, right) と表す
  (let ((left 20)
	(right 36))

    (format t "Start Game!~%")

    ;; A さんの数を 1 つに絞れないうちは繰り返す
    (loop
       ;(format t "[~S,~S)~%" left right) ;; 区間の観察
       
       (if (<= (- right left) 1) (return))
       (let ((mid (+ left (floor (/ (- right left) 2))))) ;; 区間の真ん中

	 ;; mid 以上かを聞いて、回答を yes/no で受け取る
	 (format t "Is the age less than ~S ? (yes / no)~%" mid)

	 ;; 回答に応じて、ありうる数の範囲を絞る
	 (let ((ans (string (read))))
	   (if (string-equal ans "yes")
	       (setf right mid)
	       (setf left mid)))))

    ;; ズバリ当てる！
    (format t "The age is ~S!~%" left)))

(main)
