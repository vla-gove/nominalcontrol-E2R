startup_rvc;

%insert missing matrices dh_ee2r and act_ee2r here

% inverse dynamics
ur=idynact(dh_ee2r, act_ee2r, q, qd, qdd);
%direct dynamics
t111=t';
taunom=[t111, ur];
qt=[t111, q, qd, qdd];
Pgain=[0 0]; Dgain=[0 0];
qd0=qd(1,:);
ctlname='nomctl';
global taunom qt Pgain Dgain ctlname
[tsim, q_os, qd_os]=fdynact(dh_ee2r, act_ee2r, ...
0, tf, 'nomctl', q0, qd0);
q_os=interp1(tsim, q_os, t111);
qd_os=interp1(tsim, qd_os, t111);
plot(t111, q_os-q);
plotbot(ee2rob, q_os);
%voltage supplied to motors
f_os=interp1(tsim, q_os, t111);