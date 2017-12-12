function f=charmean(g,m,n,q)
inclass= class(g);
g=im2double(g);
f=imfilter(g.^(q+1),ones(m,n),'replicate');
f=f./(imfilter(g.^q,ones(m,n),'replicate')+eps);
f=changeclass(inclass,f);