(use-modules (ice-9 rdelim)
	     (ice-9 popen))

(define (get-signature key str)
  (let* ((p2c (pipe))	 
	 (read-pipe  (car p2c))
	 (write-pipe (cdr p2c))
	 (port       (with-input-from-port read-pipe
		       (lambda ()
			 (open-input-pipe (string-append "openssl dgst -sha256 -hmac " key))))))
    (display str write-pipe)    
    (close-port write-pipe)
    (let ((result (read-line port)))
      (close-port read-pipe)
      (close-pipe port)
      (substring result 9))))
	 


