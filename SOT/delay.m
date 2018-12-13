function delay = delay(f,a);
%
global t
global DELTAT
[m,n]=size(f);
delay=zeros(size(f));
fordrojn=fix(a/DELTAT);
if (fordrojn > 0)
   delay(1+fordrojn:n)=f(1:n-fordrojn);
else
   delay(1:n+fordrojn)=f(1-fordrojn:n);
end
