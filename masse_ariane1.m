function [M]=masse_ariane1(m,k,mu)
size=length(m);
m_s=k.*m;
M_f=zeros(size,1);
M_i=zeros(size+1,1);
M_i(4)=mu;
for i=0:size-1
    M_f(size-i)=M_i(size-i+1)+m_s(size-i);
    M_i(size-i)=M_f(size-i)+m(size-i);
end
M=M_i(1);
end