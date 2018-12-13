function matlab2maple(A,namn)
%MATLAB2MAPLE H�r �r A namnet p� filen i MATLAB. D�r det st�r namn skriver du
%             mellen apostroferna '' det namn, som du vill att filen skall f� 
%             i Maple. Programmet skapar en fil kallad trans. Den placeras i  
%             det bibliotek d�r du startade MATLAB. Med kommandot  read trans;
%             l�ser du in filen i Maple (om du startat Maple fr�n samma bib-
%             liotek som MATLAB. Annars f�r du komplettera trans med v�gan-
%             givelse.) Vill du konvertera matrisen fr�n decimalform till
%             rationella tal s� skriv i Maple map(convert,namn,fraction);
                
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