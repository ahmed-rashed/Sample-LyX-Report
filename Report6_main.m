clc
close all
clearvars

set(groot,'DefaultAxesColorOrder',[0,0,1;0,0,0;1,0,0;0,0.5,0;1,0,1])
set(groot,'DefaultAxesLineStyleOrder','-|--|-.')
set(groot,'DefaultLineLineWidth',1.5);

gamma=1.4;
theta_d_vec=linspace(0,30);

M_1_vec=1.5:.5:4.5;

yAxesTitles_tex={'M_{2}','T_{2}/T_{1}','p_{2}/p_{1}','\rho_{2}/\rho_{1}'};
for ii=1:length(yAxesTitles_tex)
    subplot(length(yAxesTitles_tex),1,ii);
    hold on;
    grid;
    if ii~=length(yAxesTitles_tex), set(gca,'XTickLabel',[]);end
    
    ylabel(['$',yAxesTitles_tex{ii},'$'],'interpreter','latex');
end
xlabel('$\theta$ (degrees)','interpreter','latex'); %This applies to the bottom subplot

M_1_legend_tex=strings(length(M_1_vec),1);
ii=1;
for M_1=M_1_vec
    M_2=M_2o(M_1,theta_d_vec,gamma);
    subplot(4,1,1);plot(theta_d_vec,M_2);
    
    T_2_T_1=(1+(gamma-1)/2*M_1*M_1)./(1+(gamma-1)/2*M_2.^2);
    subplot(4,1,2);plot(theta_d_vec,T_2_T_1);
    
    p_2_p_1=T_2_T_1.^(gamma/(gamma-1));
    subplot(4,1,3);plot(theta_d_vec,p_2_p_1);
    
    rho_2_rho_1=T_2_T_1.^(1/(gamma-1));
    subplot(4,1,4);plot(theta_d_vec,rho_2_rho_1);
    
    M_1_legend_tex(ii)="$M="+M_1+'$';
    
    ii=ii+1;
end

legend(M_1_legend_tex,'interpreter','latex');

set(groot,'DefaultAxesColorOrder','remove')
set(groot,'DefaultAxesLineStyleOrder','remove')
set(groot,'DefaultLineLineWidth','remove');

export_figure(gcf,'||',{'figures'},[],{'pdf','emf'})