<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login – FoodApp</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet"/>
  <style>
    :root {
      --orange:#FF5200; --orange-lt:#FF7A3D;
      --dark:#0D0D0D; --dark2:#1A1A1A; --dark3:#252525;
      --text:#F5F5F5; --muted:#888; --white:#fff;
      --red:#fc8181; --green:#68d391;
      --font-head:'Syne',sans-serif; --font-body:'DM Sans',sans-serif;
    }
    *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
    body{
      min-height:100vh; background:var(--dark);
      display:flex; align-items:center; justify-content:center;
      font-family:var(--font-body); color:var(--text); padding:24px;
      background-image:radial-gradient(ellipse 60% 60% at 50% 0%,
        rgba(255,82,0,0.12) 0%,transparent 65%);
    }
    a{text-decoration:none;color:inherit}
    .page-wrap{width:100%;max-width:460px}
    .logo{
      font-family:var(--font-head);font-size:1.8rem;font-weight:800;
      color:var(--orange);text-align:center;margin-bottom:32px;
    }
    .logo span{color:var(--white)}
    .card{
      background:var(--dark2);border:1px solid rgba(255,255,255,0.07);
      border-radius:20px;padding:40px 36px;
      box-shadow:0 24px 64px rgba(0,0,0,0.5);
    }
    .card-title{font-family:var(--font-head);font-size:1.6rem;font-weight:800;margin-bottom:6px}
    .card-sub{font-size:0.875rem;color:var(--muted);margin-bottom:28px}

    .alert{
      padding:12px 16px;border-radius:10px;font-size:0.84rem;
      font-weight:500;margin-bottom:20px;display:flex;align-items:center;gap:8px;
    }
    .alert-error  {background:rgba(229,62,62,0.12);border:1px solid rgba(229,62,62,0.3);color:var(--red)}
    .alert-success{background:rgba(72,199,116,0.12);border:1px solid rgba(72,199,116,0.3);color:var(--green)}

    .role-label{
      font-size:0.8rem;font-weight:600;color:var(--muted);
      text-transform:uppercase;letter-spacing:0.8px;display:block;margin-bottom:10px;
    }
    .role-tabs{display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-bottom:22px}
    .role-tab{
      padding:11px;border-radius:10px;text-align:center;
      border:1.5px solid rgba(255,255,255,0.07);
      background:var(--dark3);color:var(--muted);
      font-size:0.85rem;font-weight:600;cursor:pointer;transition:all 0.2s;
    }
    .role-tab:hover{border-color:var(--orange);color:var(--orange)}
    .role-tab.selected{background:rgba(255,82,0,0.12);border-color:var(--orange);color:var(--orange)}

    .form-group{margin-bottom:18px}
    .form-group-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:8px}
    .form-group label{font-size:0.8rem;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:0.8px}
    .char-info{font-size:0.72rem;color:var(--muted)}
    .char-info.ok {color:var(--green)}
    .char-info.bad{color:var(--red)}

    .input-wrap{position:relative}
    .input-wrap input{
      width:100%;background:var(--dark3);
      border:1.5px solid rgba(255,255,255,0.07);
      border-radius:10px;padding:13px 42px 13px 16px;
      font-family:var(--font-body);font-size:0.9rem;color:var(--text);
      outline:none;transition:border-color 0.2s;
    }
    .input-wrap input:focus  {border-color:var(--orange)}
    .input-wrap input.valid  {border-color:var(--green)}
    .input-wrap input.invalid{border-color:var(--red)}
    .input-wrap input::placeholder{color:#444}
    .status-icon{position:absolute;right:14px;top:50%;transform:translateY(-50%);font-size:0.9rem}

    /* Rules dropdown */
    .rules{
      background:var(--dark3);border:1px solid rgba(255,255,255,0.06);
      border-radius:8px;padding:10px 14px;margin-top:8px;
      display:none;
    }
    .rules.show{display:block}
    .rule{
      font-size:0.75rem;padding:4px 0;
      display:flex;align-items:center;gap:8px;color:var(--muted);transition:color 0.2s;
    }
    .rule.pass{color:var(--green)}
    .rule.fail{color:var(--red)}
    .rule-dot{
      width:7px;height:7px;border-radius:50%;
      background:currentColor;flex-shrink:0;
    }

    .field-msg{font-size:0.74rem;margin-top:5px;min-height:16px}
    .field-msg.ok {color:var(--green)}
    .field-msg.bad{color:var(--red)}

    .btn-submit{
      width:100%;background:var(--orange);color:#fff;
      border:none;border-radius:10px;padding:14px;
      font-family:var(--font-head);font-size:1rem;font-weight:700;
      cursor:pointer;transition:background 0.2s,transform 0.15s;margin-top:8px;
    }
    .btn-submit:hover{background:var(--orange-lt);transform:translateY(-1px)}
    .btn-submit:disabled{background:#2a2a2a;color:#555;cursor:not-allowed;transform:none}

    .divider{
      text-align:center;color:var(--muted);font-size:0.8rem;
      margin:22px 0;position:relative;
    }
    .divider::before,.divider::after{
      content:'';position:absolute;top:50%;
      width:38%;height:1px;background:rgba(255,255,255,0.07);
    }
    .divider::before{left:0}.divider::after{right:0}
    .switch-link{text-align:center;font-size:0.875rem;color:var(--muted)}
    .switch-link a{color:var(--orange);font-weight:600}
    .switch-link a:hover{text-decoration:underline}
  </style>
</head>
<body>
<div class="page-wrap">

  <div class="logo">Food<span>App</span></div>

  <div class="card">
    <div class="card-title">Welcome back 👋</div>
    <div class="card-sub">Login to continue ordering your favourites</div>

    <%
      String error   = (String) request.getAttribute("error");
      String success = (String) request.getAttribute("success");
    %>
    <% if (error   != null) { %><div class="alert alert-error">⚠ <%= error %></div><% } %>
    <% if (success != null) { %><div class="alert alert-success">✓ <%= success %></div><% } %>

    <form action="login" method="post" id="loginForm" novalidate>

      <%-- Role --%>
      <span class="role-label">Login as</span>
      <div class="role-tabs">
        <div class="role-tab selected" onclick="selectRole('Customer',this)">🛒 Customer</div>
        <div class="role-tab"          onclick="selectRole('Admin',   this)">🛡 Admin</div>
      </div>
      <input type="hidden" name="role" id="roleInput" value="Customer"/>

      <%-- Username --%>
      <div class="form-group">
        <div class="form-group-header">
          <label>Username</label>
          <span class="char-info" id="unCount">0 / 20</span>
        </div>
        <div class="input-wrap">
          <input type="text" name="username" id="unInput"
                 placeholder="3–20 chars, letters & numbers only"
                 maxlength="20" autocomplete="username"
                 oninput="validateUN()"
                 onfocus="showR('unRules')" onblur="hideR('unRules')"/>
          <span class="status-icon" id="unIcon"></span>
        </div>
        <div class="rules" id="unRules">
          <div class="rule" id="r-unLen" ><span class="rule-dot"></span>3 to 20 characters</div>
          <div class="rule" id="r-unAlNum"><span class="rule-dot"></span>Letters and numbers only — no spaces or symbols</div>
          <div class="rule" id="r-unSql" ><span class="rule-dot"></span>No special SQL characters</div>
        </div>
        <div class="field-msg" id="unMsg"></div>
      </div>

      <%-- Password --%>
      <div class="form-group">
        <div class="form-group-header">
          <label>Password</label>
          <span class="char-info" id="pwCount">0 chars</span>
        </div>
        <div class="input-wrap">
          <input type="password" name="password" id="pwInput"
                 placeholder="Min 6 chars, 1 uppercase, 1 number"
                 oninput="validatePW()"
                 onfocus="showR('pwRules')" onblur="hideR('pwRules')"/>
          <span class="status-icon" id="pwIcon"></span>
        </div>
        <div class="rules" id="pwRules">
          <div class="rule" id="r-pwLen"><span class="rule-dot"></span>Minimum 6 characters</div>
          <div class="rule" id="r-pwUp" ><span class="rule-dot"></span>At least 1 uppercase letter (A–Z)</div>
          <div class="rule" id="r-pwNum"><span class="rule-dot"></span>At least 1 number (0–9)</div>
        </div>
        <div class="field-msg" id="pwMsg"></div>
      </div>

      <button type="submit" class="btn-submit" id="submitBtn" disabled>Login →</button>
    </form>

    <div class="divider">or</div>
    <div class="switch-link">
      Don't have an account? <a href="signup">Sign Up Free</a>
    </div>
  </div>
</div>

<script>
  // ── Role ────────────────────────────────────────────────────
  function selectRole(role, el) {
    document.querySelectorAll('.role-tab').forEach(t => t.classList.remove('selected'));
    el.classList.add('selected');
    document.getElementById('roleInput').value = role;
  }

  // ── Rules box ───────────────────────────────────────────────
  function showR(id) { document.getElementById(id).classList.add('show'); }
  function hideR(id) { setTimeout(() => document.getElementById(id).classList.remove('show'), 150); }

  // ── SQL injection patterns to block on frontend ─────────────
  const SQL_PATTERNS = [
    /'/g, /"/g, /;/g, /--/, /\/\*/, /\*\//,
    /\bdrop\b/i, /\bdelete\b/i, /\binsert\b/i,
    /\bselect\b/i, /\bunion\b/i, /\bexec\b/i,
    /\bupdate\b/i, /\balter\b/i, /\btruncate\b/i,
    /1=1/, /or\s+1/i
  ];
  function hasSql(val) {
    return SQL_PATTERNS.some(p => p.test(val));
  }

  // ── Username validation ─────────────────────────────────────
  function validateUN() {
    const val  = document.getElementById('unInput').value;
    const len  = val.length;
    const lenOk   = len >= 3 && len <= 20;
    const charOk  = /^[a-zA-Z0-9]+$/.test(val);
    const sqlOk   = !hasSql(val);

    document.getElementById('unCount').textContent = len + ' / 20';
    document.getElementById('unCount').className =
      'char-info ' + (len > 20 ? 'bad' : len >= 3 ? 'ok' : '');

    setRule('r-unLen',   lenOk);
    setRule('r-unAlNum', val === '' || charOk);
    setRule('r-unSql',   val === '' || sqlOk);

    if (val === '') { clearField('unInput','unIcon','unMsg'); checkForm(); return; }

    if (!sqlOk) {
      markBad('unInput','unIcon','unMsg','SQL characters are not allowed');
    } else if (!lenOk) {
      markBad('unInput','unIcon','unMsg','Must be 3–20 characters');
    } else if (!charOk) {
      markBad('unInput','unIcon','unMsg','Letters and numbers only');
    } else {
      markOk('unInput','unIcon','unMsg','Username looks good ✓');
    }
    checkForm();
  }

  // ── Password validation ─────────────────────────────────────
  function validatePW() {
    const val = document.getElementById('pwInput').value;
    const lenOk = val.length >= 6;
    const upOk  = /[A-Z]/.test(val);
    const numOk = /[0-9]/.test(val);

    document.getElementById('pwCount').textContent = val.length + ' chars';
    document.getElementById('pwCount').className =
      'char-info ' + (lenOk && upOk && numOk ? 'ok' : val.length > 0 ? 'bad' : '');

    setRule('r-pwLen', lenOk);
    setRule('r-pwUp',  upOk);
    setRule('r-pwNum', numOk);

    if (val === '') { clearField('pwInput','pwIcon','pwMsg'); checkForm(); return; }

    if (!lenOk) {
      markBad('pwInput','pwIcon','pwMsg','Minimum 6 characters required');
    } else if (!upOk) {
      markBad('pwInput','pwIcon','pwMsg','Add at least one uppercase letter');
    } else if (!numOk) {
      markBad('pwInput','pwIcon','pwMsg','Add at least one number');
    } else {
      markOk('pwInput','pwIcon','pwMsg','Password meets all requirements ✓');
    }
    checkForm();
  }

  // ── Enable submit only when all rules pass ──────────────────
  function checkForm() {
    const un  = document.getElementById('unInput').value;
    const pw  = document.getElementById('pwInput').value;
    const unOk = un.length >= 3 && un.length <= 20
              && /^[a-zA-Z0-9]+$/.test(un) && !hasSql(un);
    const pwOk = pw.length >= 6 && /[A-Z]/.test(pw) && /[0-9]/.test(pw);
    document.getElementById('submitBtn').disabled = !(unOk && pwOk);
  }

  // ── UI helpers ──────────────────────────────────────────────
  function markOk(inputId, iconId, msgId, msg) {
    document.getElementById(inputId).className = 'valid';
    document.getElementById(iconId).textContent = '✓';
    document.getElementById(iconId).style.color = 'var(--green)';
    document.getElementById(msgId).textContent = msg;
    document.getElementById(msgId).className = 'field-msg ok';
  }
  function markBad(inputId, iconId, msgId, msg) {
    document.getElementById(inputId).className = 'invalid';
    document.getElementById(iconId).textContent = '✗';
    document.getElementById(iconId).style.color = 'var(--red)';
    document.getElementById(msgId).textContent = msg;
    document.getElementById(msgId).className = 'field-msg bad';
  }
  function clearField(inputId, iconId, msgId) {
    document.getElementById(inputId).className = '';
    document.getElementById(iconId).textContent = '';
    document.getElementById(msgId).textContent = '';
    document.getElementById(msgId).className = 'field-msg';
  }
  function setRule(id, pass) {
    const el = document.getElementById(id);
    if (el) el.className = 'rule ' + (pass ? 'pass' : 'fail');
  }
</script>
</body>
</html>