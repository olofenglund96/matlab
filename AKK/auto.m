%%% Program for automatic determination of energi eigenvalue by iteration.
%%% Written by Solveig Skadhauge

if E>-4.0
  if E>-2.0
    step = 0.3;
  else
    step=0.5;
  end;
else
  step = 1.0;
end;

egenv=E;
EnivHLi;
sign1 = sign(wave_function1(600));

E=egenv+step;
EnivHLi;
sign2 = sign(wave_function1(600));

E=egenv-step;
EnivHLi;
sign3 = sign(wave_function1(600));

n=0;

while(step>0.000001)
  n=n+1;
  if sign1 == sign3 
     if sign1 == sign2
        %step=step*1.5
        egenv=egenv-step
        sign2=sign1;  
        sign1=sign3;
        E=egenv-step;
        EnivHLi;
        sign3=sign(wave_function1(600));
     else
        sign3=sign1;
        step = step/2; 
        E = egenv + step;
        egenv = E 
        EnivHLi;
        sign1=sign(wave_function1(600));
     end;
  else
      sign2=sign1;
      step= step/2;
      E = egenv - step;
      egenv = E
      EnivHLi;
      sign1=sign(wave_function1(600));
  end;
  if n>35
      break
  end;    
end;

