LIBRARY()

LICENSE(
    OpenSSL
    SSLeay
)



NO_COMPILER_WARNINGS()

NO_UTIL()

PEERDIR(
    contrib/libs/zlib
)

ADDINCL(
    contrib/libs/openssl/1.1.1
    contrib/libs/openssl/1.1.1/crypto
    contrib/libs/openssl/1.1.1/crypto/ec/curve448
    contrib/libs/openssl/1.1.1/crypto/ec/curve448/arch_32
    contrib/libs/openssl/1.1.1/crypto/include
    contrib/libs/openssl/1.1.1/crypto/modes
    contrib/libs/openssl/1.1.1/include
    contrib/libs/zlib
    GLOBAL contrib/libs/openssl/1.1.1/include
)

CFLAGS(
    -DECP_NISTZ256_ASM
    -DKECCAK1600_ASM
    -DOPENSSL_BN_ASM_MONT
    -DOPENSSL_CPUID_OBJ
    -DPOLY1305_ASM
    -DSHA1_ASM
    -DSHA256_ASM
    -DSHA512_ASM
    -DVPAES_ASM
)

IF (NOT OS_WINDOWS)
    CFLAGS(
        -DENGINESDIR=\"/usr/local/lib/engines-1.1\"
        -DOPENSSLDIR=\"/usr/local/ssl\"
    )
ENDIF()

IF (OS_DARWIN AND ARCH_X86_64 OR OS_LINUX AND ARCH_X86_64 OR OS_WINDOWS AND ARCH_X86_64)
    CFLAGS(
        -DAES_ASM
        -DBSAES_ASM
        -DGHASH_ASM
        -DL_ENDIAN
        -DMD5_ASM
        -DOPENSSL_BN_ASM_GF2m
        -DOPENSSL_BN_ASM_MONT5
        -DOPENSSL_IA32_SSE2
        -DPADLOCK_ASM
        -DRC4_ASM
        -DX25519_ASM
    )
ENDIF()

IF (OS_LINUX AND ARCH_AARCH64 OR OS_LINUX AND ARCH_X86_64)
    CFLAGS(-DOPENSSL_USE_NODELETE)
ENDIF()

IF (OS_DARWIN AND ARCH_X86_64)
    CFLAGS(
        -D_REENTRANT
    )
ENDIF()

IF (OS_WINDOWS AND ARCH_X86_64)
    CFLAGS(
        -DENGINESDIR="\"C:\\\\Program\ Files\\\\OpenSSL\\\\lib\\\\engines-1_1\""
        -DOPENSSLDIR="\"C:\\\\Program\ Files\\\\Common\ Files\\\\SSL\""
        -DOPENSSL_SYS_WIN32
        -DUNICODE
        -DWIN32_LEAN_AND_MEAN
        -D_CRT_SECURE_NO_DEPRECATE
        -D_UNICODE
        -D_WINSOCK_DEPRECATED_NO_WARNINGS
        /GF
    )
ENDIF()

IF (SANITIZER_TYPE STREQUAL memory)
    CFLAGS(-DPURIFY)
ENDIF()

IF (MUSL)
    CFLAGS(-DOPENSSL_NO_ASYNC)
ENDIF()

IF (ARCH_TYPE_32)
    CFLAGS(-DOPENSSL_NO_EC_NISTP_64_GCC_128)
ENDIF()

SRCDIR(
    contrib/libs/openssl/1.1.1
)

SRCS(
    crypto/aes/aes_cfb.c
    crypto/aes/aes_ecb.c
    crypto/aes/aes_ige.c
    crypto/aes/aes_misc.c
    crypto/aes/aes_ofb.c
    crypto/aes/aes_wrap.c
    crypto/aria/aria.c
    crypto/asn1/a_bitstr.c
    crypto/asn1/a_d2i_fp.c
    crypto/asn1/a_digest.c
    crypto/asn1/a_dup.c
    crypto/asn1/a_gentm.c
    crypto/asn1/a_i2d_fp.c
    crypto/asn1/a_int.c
    crypto/asn1/a_mbstr.c
    crypto/asn1/a_object.c
    crypto/asn1/a_octet.c
    crypto/asn1/a_print.c
    crypto/asn1/a_sign.c
    crypto/asn1/a_strex.c
    crypto/asn1/a_strnid.c
    crypto/asn1/a_time.c
    crypto/asn1/a_type.c
    crypto/asn1/a_utctm.c
    crypto/asn1/a_utf8.c
    crypto/asn1/a_verify.c
    crypto/asn1/ameth_lib.c
    crypto/asn1/asn1_err.c
    crypto/asn1/asn1_gen.c
    crypto/asn1/asn1_item_list.c
    crypto/asn1/asn1_lib.c
    crypto/asn1/asn1_par.c
    crypto/asn1/asn_mime.c
    crypto/asn1/asn_moid.c
    crypto/asn1/asn_mstbl.c
    crypto/asn1/asn_pack.c
    crypto/asn1/bio_asn1.c
    crypto/asn1/bio_ndef.c
    crypto/asn1/d2i_pr.c
    crypto/asn1/d2i_pu.c
    crypto/asn1/evp_asn1.c
    crypto/asn1/f_int.c
    crypto/asn1/f_string.c
    crypto/asn1/i2d_pr.c
    crypto/asn1/i2d_pu.c
    crypto/asn1/n_pkey.c
    crypto/asn1/nsseq.c
    crypto/asn1/p5_pbe.c
    crypto/asn1/p5_pbev2.c
    crypto/asn1/p5_scrypt.c
    crypto/asn1/p8_pkey.c
    crypto/asn1/t_bitst.c
    crypto/asn1/t_pkey.c
    crypto/asn1/t_spki.c
    crypto/asn1/tasn_dec.c
    crypto/asn1/tasn_enc.c
    crypto/asn1/tasn_fre.c
    crypto/asn1/tasn_new.c
    crypto/asn1/tasn_prn.c
    crypto/asn1/tasn_scn.c
    crypto/asn1/tasn_typ.c
    crypto/asn1/tasn_utl.c
    crypto/asn1/x_algor.c
    crypto/asn1/x_bignum.c
    crypto/asn1/x_info.c
    crypto/asn1/x_int64.c
    crypto/asn1/x_long.c
    crypto/asn1/x_pkey.c
    crypto/asn1/x_sig.c
    crypto/asn1/x_spki.c
    crypto/asn1/x_val.c
    crypto/async/arch/async_null.c
    crypto/async/arch/async_posix.c
    crypto/async/arch/async_win.c
    crypto/async/async.c
    crypto/async/async_err.c
    crypto/async/async_wait.c
    crypto/bf/bf_cfb64.c
    crypto/bf/bf_ecb.c
    crypto/bf/bf_enc.c
    crypto/bf/bf_ofb64.c
    crypto/bf/bf_skey.c
    crypto/bio/b_addr.c
    crypto/bio/b_dump.c
    crypto/bio/b_print.c
    crypto/bio/b_sock.c
    crypto/bio/b_sock2.c
    crypto/bio/bf_buff.c
    crypto/bio/bf_lbuf.c
    crypto/bio/bf_nbio.c
    crypto/bio/bf_null.c
    crypto/bio/bio_cb.c
    crypto/bio/bio_err.c
    crypto/bio/bio_lib.c
    crypto/bio/bio_meth.c
    crypto/bio/bss_acpt.c
    crypto/bio/bss_bio.c
    crypto/bio/bss_conn.c
    crypto/bio/bss_dgram.c
    crypto/bio/bss_fd.c
    crypto/bio/bss_file.c
    crypto/bio/bss_log.c
    crypto/bio/bss_mem.c
    crypto/bio/bss_null.c
    crypto/bio/bss_sock.c
    crypto/blake2/blake2b.c
    crypto/blake2/blake2s.c
    crypto/blake2/m_blake2b.c
    crypto/blake2/m_blake2s.c
    crypto/bn/bn_add.c
    crypto/bn/bn_blind.c
    crypto/bn/bn_const.c
    crypto/bn/bn_ctx.c
    crypto/bn/bn_depr.c
    crypto/bn/bn_dh.c
    crypto/bn/bn_div.c
    crypto/bn/bn_err.c
    crypto/bn/bn_exp.c
    crypto/bn/bn_exp2.c
    crypto/bn/bn_gcd.c
    crypto/bn/bn_gf2m.c
    crypto/bn/bn_intern.c
    crypto/bn/bn_kron.c
    crypto/bn/bn_lib.c
    crypto/bn/bn_mod.c
    crypto/bn/bn_mont.c
    crypto/bn/bn_mpi.c
    crypto/bn/bn_mul.c
    crypto/bn/bn_nist.c
    crypto/bn/bn_prime.c
    crypto/bn/bn_print.c
    crypto/bn/bn_rand.c
    crypto/bn/bn_recp.c
    crypto/bn/bn_shift.c
    crypto/bn/bn_sqr.c
    crypto/bn/bn_sqrt.c
    crypto/bn/bn_srp.c
    crypto/bn/bn_word.c
    crypto/bn/bn_x931p.c
    crypto/buffer/buf_err.c
    crypto/buffer/buffer.c
    crypto/camellia/cmll_cfb.c
    crypto/camellia/cmll_ctr.c
    crypto/camellia/cmll_ecb.c
    crypto/camellia/cmll_misc.c
    crypto/camellia/cmll_ofb.c
    crypto/cast/c_cfb64.c
    crypto/cast/c_ecb.c
    crypto/cast/c_enc.c
    crypto/cast/c_ofb64.c
    crypto/cast/c_skey.c
    crypto/cmac/cm_ameth.c
    crypto/cmac/cm_pmeth.c
    crypto/cmac/cmac.c
    crypto/cms/cms_asn1.c
    crypto/cms/cms_att.c
    crypto/cms/cms_cd.c
    crypto/cms/cms_dd.c
    crypto/cms/cms_enc.c
    crypto/cms/cms_env.c
    crypto/cms/cms_err.c
    crypto/cms/cms_ess.c
    crypto/cms/cms_io.c
    crypto/cms/cms_kari.c
    crypto/cms/cms_lib.c
    crypto/cms/cms_pwri.c
    crypto/cms/cms_sd.c
    crypto/cms/cms_smime.c
    crypto/comp/c_zlib.c
    crypto/comp/comp_err.c
    crypto/comp/comp_lib.c
    crypto/conf/conf_api.c
    crypto/conf/conf_def.c
    crypto/conf/conf_err.c
    crypto/conf/conf_lib.c
    crypto/conf/conf_mall.c
    crypto/conf/conf_mod.c
    crypto/conf/conf_sap.c
    crypto/conf/conf_ssl.c
    crypto/cpt_err.c
    crypto/cryptlib.c
    crypto/ct/ct_b64.c
    crypto/ct/ct_err.c
    crypto/ct/ct_log.c
    crypto/ct/ct_oct.c
    crypto/ct/ct_policy.c
    crypto/ct/ct_prn.c
    crypto/ct/ct_sct.c
    crypto/ct/ct_sct_ctx.c
    crypto/ct/ct_vfy.c
    crypto/ct/ct_x509v3.c
    crypto/ctype.c
    crypto/cversion.c
    crypto/des/cbc_cksm.c
    crypto/des/cbc_enc.c
    crypto/des/cfb64ede.c
    crypto/des/cfb64enc.c
    crypto/des/cfb_enc.c
    crypto/des/des_enc.c
    crypto/des/ecb3_enc.c
    crypto/des/ecb_enc.c
    crypto/des/fcrypt.c
    crypto/des/fcrypt_b.c
    crypto/des/ofb64ede.c
    crypto/des/ofb64enc.c
    crypto/des/ofb_enc.c
    crypto/des/pcbc_enc.c
    crypto/des/qud_cksm.c
    crypto/des/rand_key.c
    crypto/des/set_key.c
    crypto/des/str2key.c
    crypto/des/xcbc_enc.c
    crypto/dh/dh_ameth.c
    crypto/dh/dh_asn1.c
    crypto/dh/dh_check.c
    crypto/dh/dh_depr.c
    crypto/dh/dh_err.c
    crypto/dh/dh_gen.c
    crypto/dh/dh_kdf.c
    crypto/dh/dh_key.c
    crypto/dh/dh_lib.c
    crypto/dh/dh_meth.c
    crypto/dh/dh_pmeth.c
    crypto/dh/dh_prn.c
    crypto/dh/dh_rfc5114.c
    crypto/dh/dh_rfc7919.c
    crypto/dsa/dsa_ameth.c
    crypto/dsa/dsa_asn1.c
    crypto/dsa/dsa_depr.c
    crypto/dsa/dsa_err.c
    crypto/dsa/dsa_gen.c
    crypto/dsa/dsa_key.c
    crypto/dsa/dsa_lib.c
    crypto/dsa/dsa_meth.c
    crypto/dsa/dsa_ossl.c
    crypto/dsa/dsa_pmeth.c
    crypto/dsa/dsa_prn.c
    crypto/dsa/dsa_sign.c
    crypto/dsa/dsa_vrf.c
    crypto/dso/dso_dl.c
    crypto/dso/dso_err.c
    crypto/dso/dso_lib.c
    crypto/dso/dso_openssl.c
    crypto/dso/dso_vms.c
    crypto/dso/dso_win32.c
    crypto/ebcdic.c
    crypto/ec/curve25519.c
    crypto/ec/curve448/arch_32/f_impl.c
    crypto/ec/curve448/curve448.c
    crypto/ec/curve448/curve448_tables.c
    crypto/ec/curve448/eddsa.c
    crypto/ec/curve448/f_generic.c
    crypto/ec/curve448/scalar.c
    crypto/ec/ec2_oct.c
    crypto/ec/ec2_smpl.c
    crypto/ec/ec_ameth.c
    crypto/ec/ec_asn1.c
    crypto/ec/ec_check.c
    crypto/ec/ec_curve.c
    crypto/ec/ec_cvt.c
    crypto/ec/ec_err.c
    crypto/ec/ec_key.c
    crypto/ec/ec_kmeth.c
    crypto/ec/ec_lib.c
    crypto/ec/ec_mult.c
    crypto/ec/ec_oct.c
    crypto/ec/ec_pmeth.c
    crypto/ec/ec_print.c
    crypto/ec/ecdh_kdf.c
    crypto/ec/ecdh_ossl.c
    crypto/ec/ecdsa_ossl.c
    crypto/ec/ecdsa_sign.c
    crypto/ec/ecdsa_vrf.c
    crypto/ec/eck_prn.c
    crypto/ec/ecp_mont.c
    crypto/ec/ecp_nist.c
    crypto/ec/ecp_nistp224.c
    crypto/ec/ecp_nistp256.c
    crypto/ec/ecp_nistp521.c
    crypto/ec/ecp_nistputil.c
    crypto/ec/ecp_nistz256.c
    crypto/ec/ecp_oct.c
    crypto/ec/ecp_smpl.c
    crypto/ec/ecx_meth.c
    crypto/engine/eng_all.c
    crypto/engine/eng_cnf.c
    crypto/engine/eng_ctrl.c
    crypto/engine/eng_dyn.c
    crypto/engine/eng_err.c
    crypto/engine/eng_fat.c
    crypto/engine/eng_init.c
    crypto/engine/eng_lib.c
    crypto/engine/eng_list.c
    crypto/engine/eng_openssl.c
    crypto/engine/eng_pkey.c
    crypto/engine/eng_rdrand.c
    crypto/engine/eng_table.c
    crypto/engine/tb_asnmth.c
    crypto/engine/tb_cipher.c
    crypto/engine/tb_dh.c
    crypto/engine/tb_digest.c
    crypto/engine/tb_dsa.c
    crypto/engine/tb_eckey.c
    crypto/engine/tb_pkmeth.c
    crypto/engine/tb_rand.c
    crypto/engine/tb_rsa.c
    crypto/err/err.c
    crypto/err/err_all.c
    crypto/err/err_prn.c
)

END()
