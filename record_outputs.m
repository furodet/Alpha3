mkdir out;
dco_out = out.yout.get("dco_out").Values.Data;
audiowrite("out/dco_out.wav", dco_out, 44100);
hp_out = out.yout.get("hp_out").Values.Data;
audiowrite("out/hp_out.wav", hp_out, 44100);
mix_out = out.yout.get("dca_out").Values.Data;
audiowrite("out/dca_out.wav", mix_out, 44100);