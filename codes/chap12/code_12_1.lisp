(defun insertion-sort (a)
  (loop for i from 1 below (length a)
     do (let ((v (aref a i))  ;; 挿入したい値
	      (j i))
	  
	  ;; v を挿入する適切な場所 j を探す
	  (loop
	     while (> j 0)
	     do (if (> (aref a (1- j)) v) ;; v より大きいものは 1 つ後ろに移す
		    (setf (aref a j) (aref a (1- j)))
		    (return)) ;;  v 以下になったら止める
		(decf j))

	  (setf (aref a j) v)))) ;; 最後に j 番目に v をもってくる

(defun main ()
  (let ((N) (a))
    ;; 入力
    (setf N (read)); // 要素数
    (setf a (make-array N))
    (loop for i below N
       do (setf (aref a i) (read)))
    
    ;; 挿入ソート
    (insertion-sort a)))

(main)
