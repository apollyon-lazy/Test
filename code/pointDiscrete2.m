clear;
clc;

tic;
%% Initial geometry parameters
Geometry.alpha_P=pi*45/180;         %[rad] the degree between the points of the platform
Geometry.alpha_B=pi*35/180;         %[rad] the degree between the points of the base
Geometry.r_B=136;                   %[mm] Radius of the circumcircle of the base
Geometry.r_P=79;                    %[mm] Radius of the circumcircle of the platform
Geometry.origin_height=[0,0,60]';   %[mm] the origin position of the center of platform

Geometry.length = [80,160];         %[mm] length of the arm      
Geometry.angle_P = [0,pi/3];        %[rad] Max angle of the platform joint          
Geometry.angle_B = [0,pi/6];        %[rad] Max angle of the base joint

%% Initial process parameter
Init.phi = [-pi/6,pi/6];
Init.theta = [-pi/6,pi/6];
Init.psi = [-pi/6,pi/6];
Init.theta_step = pi/81;
Init.phi_step = pi/81;
Init.psi_step = pi/81;
% Init.orient = [0,0,0]';
Init.trans = [0,0,60]';

%% Main process 

% Calculate geometry parameter
[attach_P,attach_B,vec_dir] = Stewartparam(Geometry);
% Calculate Constant-position workspace
point = pointConstPos(Init,Geometry,attach_P,attach_B,vec_dir);

toc;
T = toc;
fprintf('Calculation finished!\n');
%% Post-processing 

pointd = rad2deg(point);
scatter3(pointd(1,:),pointd(2,:),pointd(3,:),'filled'); 
grid on;
view(30,30);
xlabel('theta');ylabel('phi');zlabel('psi');
title(['T = ',num2str(T),'s'],'Color','blue');

savefig('.\fig\draw.fig');