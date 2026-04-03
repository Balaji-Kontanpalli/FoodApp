<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Sign Up – FoodApp</title>
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
      font-family:var(--font-body); color:var(--text); padding:40px 24px;
      background-image:radial-gradient(ellipse 60% 60% at 50% 0%,
        rgba(255,82,0,0.12) 0%,transparent 65%);
    }
    a{text-decoration:none;color:inherit}
    .page-wrap{width:100%;max-width:520px}
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

    /* Alert */
    .alert{
      padding:12px 16px;border-radius:10px;font-size:0.84rem;
      font-weight:500;margin-bottom:20px;display:flex;align-items:center;gap:8px;
    }
    .alert-error  {background:rgba(229,62,62,0.12);border:1px solid rgba(229,62,62,0.3);color:var(--red)}

    /* Two column row */
    .form-row{display:grid;grid-template-columns:1fr 1fr;gap:16px}

    /* Form group */
    .form-group{margin-bottom:16px}
    .form-group-header{
      display:flex;justify-content:space-between;
      align-items:center;margin-bottom:8px;
    }
    .form-group label{
      font-size:0.8rem;font-weight:600;color:var(--muted);
      text-transform:uppercase;letter-spacing:0.8px;
    }
    .char-info{font-size:0.72rem;color:var(--muted)}
    .char-info.ok {color:var(--green)}
    .char-info.bad{color:var(--red)}

    /* Input */
    .input-wrap{position:relative}
    .input-wrap input{
      width:100%;background:var(--dark3);
      border:1.5px solid rgba(255,255,255,0.07);
      border-radius:10px;padding:12px 40px 12px 14px;
      font-family:var(--font-body);font-size:0.875rem;color:var(--text);
      outline:none;transition:border-color 0.2s;
    }
    .input-wrap input:focus  {border-color:var(--orange)}
    .input-wrap input.valid  {border-color:var(--green)}
    .input-wrap input.invalid{border-color:var(--red)}
    .input-wrap input::placeholder{color:#444}
    .status-icon{
      position:absolute;right:12px;top:50%;
      transform:translateY(-50%);font-size:0.85rem;
    }

    /* Rules */
    .rules{
      background:var(--dark3);border:1px solid rgba(255,255,255,0.05);
      border-radius:8px;padding:10px 14px;margin-top:6px;display:none;
    }
    .rules.show{display:block}
    .rule{
      font-size:0.74rem;padding:3px 0;
      display:flex;align-items:center;gap:8px;
      color:var(--muted);transition:color 0.2s;
    }
    .rule.pass{color:var(--green)}
    .rule.fail{color:var(--red)}
    .rule-dot{width:6px;height:6px;border-radius:50%;background:currentColor;flex-shrink:0}

    /* Field message */
    .field-msg{font-size:0.74rem;margin-top:5px;min-height:16px}
    .field-msg.ok {color:var(--green)}
    .field-msg.bad{color:var(--red)}

    /* Password strength bar */
    .strength-wrap{margin-top:8px}
    .strength-bar{height:4px;border-radius:2px;background:var(--dark3);overflow:hidden}
    .strength-fill{height:100%;border-radius:2px;width:0%;transition:width 0.3s,background 0.3s}
    .strength-label{font-size:0.72rem;color:var(--muted);margin-top:4px}

    /* Terms */
    .terms{
      display:flex;align-items:flex-start;gap:10px;
      margin:16px 0;font-size:0.82rem;color:var(--muted);
    }
    .terms input[type="checkbox"]{margin-top:2px;accent-color:var(--orange);cursor:pointer}
    .terms a{color:var(--orange)}

    /* Submit */
    .btn-submit{
      width:100%;background:var(--orange);color:#fff;
      border:none;border-radius:10px;padding:14px;
      font-family:var(--font-head);font-size:1rem;font-weight:700;
      cursor:pointer;transition:background 0.2s,transform 0.15s;
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
    <div class="card-title">Create account 🍽</div>
    <div class="card-sub">Join FoodApp and start ordering today</div>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
      <div class="alert alert-error">⚠ <%= error %></div>
    <% } %>

    <form action="signup" method="post" id="signupForm" novalidate>

      <%-- Row 1: Username + Email --%>
      <div class="form-row">

        <%-- Username --%>
        <div class="form-group">
          <div class="form-group-header">
            <label>Username</label>
            <span class="char-info" id="unCount">0/20</span>
          </div>
          <div class="input-wrap">
            <input type="text" name="username" id="unInput"
                   placeholder="3–20 chars" maxlength="20"
                   oninput="validateUN()"
                   onfocus="showR('unRules')" onblur="hideR('unRules')"/>
            <span class="status-icon" id="unIcon"></span>
          </div>
          <div class="rules" id="unRules">
            <div class="rule" id="r-unLen" ><span class="rule-dot"></span>3 to 20 characters</div>
            <div class="rule" id="r-unChar"><span class="rule-dot"></span>Letters & numbers only</div>
            <div class="rule" id="r-unSql" ><span class="rule-dot"></span>No SQL characters</div>
          </div>
          <div class="field-msg" id="unMsg"></div>
        </div>

        <%-- Email --%>
        <div class="form-group">
          <div class="form-group-header">
            <label>Email</label>
          </div>
          <div class="input-wrap">
            <input type="email" name="email" id="emInput"
                   placeholder="your@email.com"
                   oninput="validateEM()"
                   onfocus="showR('emRules')" onblur="hideR('emRules')"/>
            <span class="status-icon" id="emIcon"></span>
          </div>
          <div class="rules" id="emRules">
            <div class="rule" id="r-emFmt"><span class="rule-dot"></span>Valid format: name@domain.com</div>
            <div class="rule" id="r-emSql"><span class="rule-dot"></span>No SQL characters</div>
          </div>
          <div class="field-msg" id="emMsg"></div>
        </div>

      </div>

      <%-- Address --%>
      <div class="form-group">
        <div class="form-group-header">
          <label>Address</label>
          <span class="char-info" id="adCount">0/100</span>
        </div>
        <div class="input-wrap">
          <input type="text" name="address" id="adInput"
                 placeholder="Your city or area (3–100 chars)" maxlength="100"
                 oninput="validateAD()"
                 onfocus="showR('adRules')" onblur="hideR('adRules')"/>
          <span class="status-icon" id="adIcon"></span>
        </div>
        <div class="rules" id="adRules">
          <div class="rule" id="r-adLen"><span class="rule-dot"></span>3 to 100 characters</div>
          <div class="rule" id="r-adSql"><span class="rule-dot"></span>No SQL characters</div>
        </div>
        <div class="field-msg" id="adMsg"></div>
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
        <div class="strength-wrap">
          <div class="strength-bar"><div class="strength-fill" id="sFill"></div></div>
          <div class="strength-label" id="sLabel">Enter a password</div>
        </div>
        <div class="field-msg" id="pwMsg"></div>
      </div>

      <%-- Confirm Password --%>
      <div class="form-group">
        <div class="form-group-header">
          <label>Confirm Password</label>
        </div>
        <div class="input-wrap">
          <input type="password" name="confirmPassword" id="cpInput"
                 placeholder="Re-enter your password"
                 oninput="validateCP()"/>
          <span class="status-icon" id="cpIcon"></span>
        </div>
        <div class="field-msg" id="cpMsg"></div>
      </div>

      <%-- Terms --%>
      <div class="terms">
        <input type="checkbox" id="termsBox" onchange="checkForm()"/>
        <label for="termsBox">
          I agree to the <a href="#">Terms & Conditions</a>
          and <a href="#">Privacy Policy</a>
        </label>
      </div>

      <button type="submit" class="btn-submit" id="submitBtn" disabled>
        Create Account →
      </button>
    </form>

    <div class="divider">or</div>
    <div class="switch-link">
      Already have an account? <a href="login">Login</a>
    </div>
  </div>
</div>

<script>
  // ── SQL patterns ─────────────────────────────────────────────
  const SQL_P = [
    /'/g,/";/,/--/,/\/\*/,/\*\//,
    /\bdrop\b/i,/\bdelete\b/i,/\binsert\b/i,
    /\bselect\b/i,/\bunion\b/i,/\bexec\b/i,
    /\bupdate\b/i,/\balter\b/i,/\btruncate\b/i,
    /1=1/,/or\s+1/i
  ];
  const hasSql = v => SQL_P.some(p => p.test(v));

  // ── Show / hide rules ─────────────────────────────────────────
  function showR(id){ document.getElementById(id).classList.add('show') }
  function hideR(id){ setTimeout(()=>document.getElementById(id).classList.remove('show'),150) }

  // ── Username ──────────────────────────────────────────────────
  function validateUN(){
    const v = document.getElementById('unInput').value;
    const lenOk  = v.length>=3 && v.length<=20;
    const charOk = /^[a-zA-Z0-9]+$/.test(v);
    const sqlOk  = !hasSql(v);
    document.getElementById('unCount').textContent = v.length+'/20';
    document.getElementById('unCount').className =
      'char-info '+(v.length>20?'bad':v.length>=3?'ok':'');
    setRule('r-unLen', lenOk);
    setRule('r-unChar',v===''||charOk);
    setRule('r-unSql', v===''||sqlOk);
    if(v===''){clr('unInput','unIcon','unMsg');checkForm();return}
    if(!sqlOk)  bad('unInput','unIcon','unMsg','SQL characters not allowed');
    else if(!lenOk) bad('unInput','unIcon','unMsg','Must be 3–20 characters');
    else if(!charOk)bad('unInput','unIcon','unMsg','Letters and numbers only');
    else            ok ('unInput','unIcon','unMsg','Username looks good ✓');
    checkForm();
  }

  // ── Email ─────────────────────────────────────────────────────
  function validateEM(){
    const v = document.getElementById('emInput').value;
    const fmtOk = /^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(v);
    const sqlOk = !hasSql(v);
    setRule('r-emFmt', v===''||fmtOk);
    setRule('r-emSql', v===''||sqlOk);
    if(v===''){clr('emInput','emIcon','emMsg');checkForm();return}
    if(!sqlOk) bad('emInput','emIcon','emMsg','SQL characters not allowed');
    else if(!fmtOk)bad('emInput','emIcon','emMsg','Enter a valid email (e.g. name@domain.com)');
    else           ok ('emInput','emIcon','emMsg','Valid email ✓');
    checkForm();
  }

  // ── Address ───────────────────────────────────────────────────
  function validateAD(){
    const v = document.getElementById('adInput').value;
    const lenOk = v.length>=3 && v.length<=100;
    const sqlOk = !hasSql(v);
    document.getElementById('adCount').textContent = v.length+'/100';
    document.getElementById('adCount').className =
      'char-info '+(v.length>100?'bad':v.length>=3?'ok':'');
    setRule('r-adLen',lenOk);
    setRule('r-adSql',v===''||sqlOk);
    if(v===''){clr('adInput','adIcon','adMsg');checkForm();return}
    if(!sqlOk)   bad('adInput','adIcon','adMsg','SQL characters not allowed');
    else if(!lenOk)bad('adInput','adIcon','adMsg','Must be 3–100 characters');
    else           ok ('adInput','adIcon','adMsg','Address looks good ✓');
    checkForm();
  }

  // ── Password ──────────────────────────────────────────────────
  function validatePW(){
    const v   = document.getElementById('pwInput').value;
    const len = v.length>=6;
    const up  = /[A-Z]/.test(v);
    const num = /[0-9]/.test(v);
    document.getElementById('pwCount').textContent = v.length+' chars';
    document.getElementById('pwCount').className =
      'char-info '+(len&&up&&num?'ok':v.length>0?'bad':'');
    setRule('r-pwLen',len);
    setRule('r-pwUp', up);
    setRule('r-pwNum',num);

    // Strength bar
    const score = [len,up,num,v.length>=10].filter(Boolean).length;
    const levels=[
      {w:'0%',  c:'transparent',t:'Enter a password'},
      {w:'25%', c:'#e53e3e',    t:'Weak'},
      {w:'50%', c:'#ed8936',    t:'Fair'},
      {w:'75%', c:'#ecc94b',    t:'Good'},
      {w:'100%',c:'#48c774',    t:'Strong ✓'},
    ];
    document.getElementById('sFill').style.width      = levels[score].w;
    document.getElementById('sFill').style.background = levels[score].c;
    document.getElementById('sLabel').textContent     = levels[score].t;
    document.getElementById('sLabel').style.color     = levels[score].c;

    if(v===''){clr('pwInput','pwIcon','pwMsg');checkForm();return}
    if(!len)    bad('pwInput','pwIcon','pwMsg','Minimum 6 characters required');
    else if(!up)bad('pwInput','pwIcon','pwMsg','Add at least one uppercase letter');
    else if(!num)bad('pwInput','pwIcon','pwMsg','Add at least one number');
    else         ok ('pwInput','pwIcon','pwMsg','Password meets all requirements ✓');

    validateCP(); // re-check confirm if already typed
    checkForm();
  }

  // ── Confirm Password ──────────────────────────────────────────
  function validateCP(){
    const pw = document.getElementById('pwInput').value;
    const cp = document.getElementById('cpInput').value;
    if(cp===''){clr('cpInput','cpIcon','cpMsg');checkForm();return}
    if(pw===cp) ok ('cpInput','cpIcon','cpMsg','Passwords match ✓');
    else        bad('cpInput','cpIcon','cpMsg','Passwords do not match');
    checkForm();
  }

  // ── Enable submit when all valid ──────────────────────────────
  function checkForm(){
    const un = document.getElementById('unInput').value;
    const em = document.getElementById('emInput').value;
    const ad = document.getElementById('adInput').value;
    const pw = document.getElementById('pwInput').value;
    const cp = document.getElementById('cpInput').value;

    const unOk = un.length>=3 && un.length<=20 && /^[a-zA-Z0-9]+$/.test(un) && !hasSql(un);
    const emOk = /^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(em) && !hasSql(em);
    const adOk = ad.length>=3 && ad.length<=100 && !hasSql(ad);
    const pwOk = pw.length>=6 && /[A-Z]/.test(pw) && /[0-9]/.test(pw);
    const cpOk = pw===cp && cp!=='';
    const terms = document.getElementById('termsBox').checked;

    document.getElementById('submitBtn').disabled = !(unOk&&emOk&&adOk&&pwOk&&cpOk&&terms);
  }

  // ── UI helpers ────────────────────────────────────────────────
  function ok(inp,ico,msg,txt){
    document.getElementById(inp).className='valid';
    document.getElementById(ico).textContent='✓';
    document.getElementById(ico).style.color='var(--green)';
    document.getElementById(msg).textContent=txt;
    document.getElementById(msg).className='field-msg ok';
  }
  function bad(inp,ico,msg,txt){
    document.getElementById(inp).className='invalid';
    document.getElementById(ico).textContent='✗';
    document.getElementById(ico).style.color='var(--red)';
    document.getElementById(msg).textContent=txt;
    document.getElementById(msg).className='field-msg bad';
  }
  function clr(inp,ico,msg){
    document.getElementById(inp).className='';
    document.getElementById(ico).textContent='';
    document.getElementById(msg).textContent='';
    document.getElementById(msg).className='field-msg';
  }
  function setRule(id,pass){
    const el=document.getElementById(id);
    if(el) el.className='rule '+(pass?'pass':'fail');
  }
</script>
</body>
</html>