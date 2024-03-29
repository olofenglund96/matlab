e_m = 1;
a_v = 15.5*e_m;
a_s = 16.8*e_m;
a_c = 0.72*e_m;
a_sym = 23*e_m;
a_p = 34*e_m;

% de1 = a_p*A^(-3/4);
% de2 = 0;
% de3 = -a_p*A^(-3/4);
B = @(A, Z, de) a_v*A-a_s*A^(2/3)-a_c*Z*(Z-1)/A^(1/3)-a_sym*(A-2*Z)^2/A+de*a_p*A^(-3/4);

M = @(Z, A, de) Z*(me+mp) + (A-Z)*mn - B(A, Z, de)/ev_adj;
Q_bm = @(m_x, m_y) (m_x - m_y)*ev_adj;
Q_bp = @(m_x, m_y) (m_x - m_y - 2*me)*ev_adj;
Q_ec = @(m_x, m_y, B) Q_bm(m_x, m_y) - B;

m_fe = M(26, 55, 0)
m_mn = M(25, 55, 0)
m_co = M(27, 55, 0)
Q_bm(m_fe, m_co)
Q_bp(m_fe, m_mn)

Q_org = @(m_a, m_A, m_b, m_B) (m_a + m_A - m_b - m_B)*ev_adj;

