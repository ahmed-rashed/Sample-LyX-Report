function M_2_vec=M_2o(M_1,theta_d_vec, ...
                      gamma)    %optional arguments
if nargin<3
    gamma=1.4;
end

theta_vec=deg2rad(theta_d_vec);
n1=sqrt((gamma+1)/(gamma-1))*atan(sqrt((gamma-1)/(gamma+1)*(M_1^2-1)))-atan(sqrt(M_1^2-1));

%Newton Raphson iteration
M_2_vec=1.1*ones(size(theta_d_vec));
for ii=1:length(theta_d_vec)
    f=sqrt((gamma+1)/(gamma-1))*atan(sqrt((gamma-1)/(gamma+1)*(M_2_vec(ii)^2-1)))-atan(sqrt(M_2_vec(ii)^2-1))-theta_vec(ii)-n1;
    fdash=1/(M_2_vec(ii)^2-1)^(1/2)*M_2_vec(ii)/(1+(gamma-1)/(gamma+1)*(M_2_vec(ii)^2-1))-1/(M_2_vec(ii)^2-1)^(1/2)/M_2_vec(ii);

    M_2_n=M_2_vec(ii)-f/fdash;
    while abs(M_2_vec(ii)-M_2_n)>=100*eps %This is dangerous. Infinte loop can occur!!
        M_2_vec(ii)=M_2_n;
        f=sqrt((gamma+1)/(gamma-1))*atan(sqrt((gamma-1)/(gamma+1)*(M_2_vec(ii)^2-1)))-atan(sqrt(M_2_vec(ii)^2-1))-theta_vec(ii)-n1;
        fdash=1/(M_2_vec(ii)^2-1)^(1/2)*M_2_vec(ii)/(1+(gamma-1)/(gamma+1)*(M_2_vec(ii)^2-1))-1/(M_2_vec(ii)^2-1)^(1/2)/M_2_vec(ii);
        M_2_n=M_2_vec(ii)-f./fdash;
    end
    M_2_vec(ii)=M_2_n;
end