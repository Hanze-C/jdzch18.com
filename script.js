(function(){
  const params = new URLSearchParams(window.location.search);
  const raw = params.get('url');
  const hostEl = document.getElementById('host');
  const hrefEl = document.getElementById('href');
  const msgEl = document.getElementById('message');
  const btnContinue = document.getElementById('continue');
  const btnCancel = document.getElementById('cancel');
  // 新标签页选项已移除，始终在当前窗口跳转
  let destUrl = null;

  if(!raw){
    msgEl.textContent = '未检测到目标链接，请使用 ?url= 参数。';
    disableControls();
    return;
  }

  try{
    destUrl = new URL(raw);
  }catch(e){
    msgEl.textContent = '目标链接格式无效，请提供完整的 http:// 或 https:// 地址。';
    disableControls();
    return;
  }

  if(destUrl.protocol !== 'http:' && destUrl.protocol !== 'https:'){
    msgEl.textContent = '仅支持 http(s) 协议的外部链接。';
    disableControls();
    return;
  }

  hostEl.textContent = destUrl.hostname;
  hrefEl.textContent = destUrl.href;
  msgEl.textContent = '点击“继续前往”以访问外部链接。';

  btnContinue.addEventListener('click', ()=>{
    doRedirect();
  });

  btnCancel.addEventListener('click', ()=>{
    // Prefer explicit referrer navigation when available, otherwise fall back to history.back()
    try{
      if(document.referrer){
        window.location.href = document.referrer;
      }else{
        history.back();
      }
    }catch(e){
      try{ history.back(); }catch(_){}
    }
  });

  function disableControls(){
    btnContinue.disabled = true;
    btnCancel.textContent = '返回';
  }

  function doRedirect(){
    if(!destUrl) return;
    const href = destUrl.href;
    window.location.href = href;
  }
})();
