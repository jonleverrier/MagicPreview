<!doctype html>
<html lang="{$config.manager_language|escape}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>{$_lang['magicpreview.preview']} {$resource.pagetitle|escape}</title>
    <link rel="stylesheet" href="{$mp_config.assetsUrl}preview.css">
</head>
<body>
{if $resource['id'] > 0}
    <div id="container">
        <div id="info">
            <h1 class="resource">
                <span class="preview-prefix">{$_lang['magicpreview.preview']}</span>
                <a href="{$config.manager_url}?a=resource/update&id={$resource.id}">
                    {$resource.pagetitle|escape}
                </a>
            </h1>

            <div class="breakpoints">
                <input type="radio" name="breakpoint" value="full" id="breakpoint-full" checked>
                <div class="breakpoint">
                    <label for="breakpoint-full">{$_lang['magicpreview.bp_full']}</label>
                </div>

                <input type="radio" name="breakpoint" value="desktop" id="breakpoint-desktop">
                <div class="breakpoint">
                    <label for="breakpoint-desktop">{$_lang['magicpreview.bp_desktop']}</label>
                </div>

                <input type="radio" name="breakpoint" value="tablet" id="breakpoint-tablet">
                <div class="breakpoint">
                    <label for="breakpoint-tablet">{$_lang['magicpreview.bp_tablet']}</label>
                </div>

                <input type="radio" name="breakpoint" value="mobile" id="breakpoint-mobile">
                <div class="breakpoint">
                    <label for="breakpoint-mobile">{$_lang['magicpreview.bp_mobile']}</label>
                </div>
            </div>
        </div>
        <div id="frame-wrapper">
            <iframe id="frame"></iframe>
        </div>
        <div id="loading-wrapper">
            <p>{$_lang['magicpreview.preparing_preview']}</p>
        </div>
    </div>
    <script>
        (function() {
            var frame = document.getElementById('frame'),
                frameWrapper = document.getElementById('frame-wrapper'),
                loadingWrapper = document.getElementById('loading-wrapper'),
                baseFrameUrl = '{$baseFrameUrl|escape:javascript}',
                joiner = baseFrameUrl.indexOf('?') === -1 ? '?' : '&';
            window.onhashchange = refreshFrame;
            refreshFrame();

            function refreshFrame() {
                if (location.hash === '' || location.hash === '#loading') {
                    frameWrapper.style.display = 'none';
                    loadingWrapper.style.display = 'flex';
                    frame.src = '';
                }
                else {
                    loadingWrapper.style.display = 'none';
                    frameWrapper.style.display = 'flex';
                    frame.src = baseFrameUrl + joiner + 'show_preview=' + location.hash.substring(1);
                }
            }

            // Handle dynamic breakpoint sizing
            var breakpoints = document.querySelectorAll('.breakpoints input');
            breakpoints.forEach(function(bp) {
                bp.addEventListener('change', function () {
                    switch (this.value) {
                        case 'full':
                            frameWrapper.style.width = '100%';
                            break;

                        case 'desktop':
                            frameWrapper.style.width = '1280px';
                            break;

                        case 'tablet':
                            frameWrapper.style.width = '768px';
                            break;

                        case 'mobile':
                            frameWrapper.style.width = '320px';
                            break;
                    }
                });
            });
        })()
    </script>
{else}
    <div id="container">
        <div id="info">
            <h1 class="resource">
                Resource not found
            </h1>
        </div>
    </div>
{/if}
</body>
</html>