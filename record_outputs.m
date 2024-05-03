mkdir out;
dco_out = out.yout.get("dco_out").Values.Data;
audiowrite("out/dco_out.wav", dco_out, 44100);
hp_out = out.yout.get("hp_out").Values.Data;
audiowrite("out/hp_out.wav", hp_out, 44100);