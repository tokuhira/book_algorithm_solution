;; i 番目の頂点を根とする部分木について，ヒープ条件を満たすようにする
;; a のうち 0 番目から N-1 番目までの部分 a[0:N] についてのみ考える
(defun heapify (a i N)
  (let ((child1 (1+ (* i 2)))) ;; 左の子供
    (if (>= child1 N) (return-from heapify)) ;; 子供がないときは終了

    ;; 子供同士を比較
    (if (and (< (1+ child1) N)
	     (> (aref a (1+ child1)) (aref a child1)))
	(incf child1))
    
    (if (<= (aref a child1) (aref a i))
	(return-from heapify)) ;; 逆転がなかったら終了

    ;; swap
    (rotatef (aref a i) (aref a child1))

    ;; 再帰的に
    (heapify a child1 N)))

;; 配列 a をソートする
(defun heap-sort (a)
  (let ((N (length a)))

    ;; ステップ 1: a 全体をヒープにするフェーズ
    (loop for i from (1- (floor N 2)) downto 0
       do (heapify a i N))

    ;; ステップ 2: ヒープから 1 個 1 個最大値を pop するフェーズ
    (loop for i downfrom (1- N) above 0
       do (rotatef (aref a 0) (aref a i)) ;; ヒープの最大値を左詰め
	  (heapify a 0 i)))) ;; ヒープサイズは i に

(defun main ()
  ;; 入力
  (let ((N) (a))
    (setf N (read)) ;; 要素数
    (setf a (make-array N))
    (loop for i below N
       do (setf (aref a i) (read)))

    ;; ヒープソート
    (heap-sort a)))

(main)
