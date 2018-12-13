function matlab2maple(A,namn)
%MATLAB2MAPLE Här är A namnet på filen i MATLAB. Där det står namn skriver du
%             mellen apostroferna '' det namn, som du vill att filen skall få 
%             i Maple. Programmet skapar en fil kallad trans. Den placeras i  
%             det bibliotek där du startade MATLAB. Med kommandot  read trans;
%             läser du in filen i Maple (om du startat Maple från samma bib-
%             liotek som MATLAB. Annars får du komplettera trans med vägan-
%             givelse.) Vill du konvertera matrisen från decimalform till
%             rationella tal så skriv i Maple map(convert,namn,fraction);
                
[m,n]=size(A);
s=sprintf(namn);
s=[s ':=matrix('];
s=[s num2str(m) ',' num2str(n) ',['];
for i=1:m 
   temp=sprintf(',%6.16g',A(i,:));
   temp=temp(2:length(temp));
   s=[s temp ','];
end
s=s(1:length(s)-1);
s=[s ']);'];
fid=fopen('trans','wt');
fprintf(fid,s);
fclose(fid);
%Slut matlab2maple  JG 1995-02-26