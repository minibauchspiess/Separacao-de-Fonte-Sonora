load fisheriris
[W2,H2] = nnmf(meas, 2);
[W3,H3] = nnmf(meas, 3);
[WT2,HT2] = nnmf(transpose(meas), 2);
[WT3,HT3] = nnmf(transpose(meas), 3);