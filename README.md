# Onepay Gateway

Use nginx to host php service (product)
Or use Xampp (Mac Test)
```
location ~ \.php$ {
       client_max_body_size 200M;
       fastcgi_pass unix:/var/run/php5-fpm.sock;
       fastcgi_index index.php;
       fastcgi_param  SCRIPT_FILENAME /home/github/immobile$fastcgi_script_name;
       include fastcgi_params;
  }
```

Change secure key in 
```/onepay/dr.php 
/onepay/do.php```