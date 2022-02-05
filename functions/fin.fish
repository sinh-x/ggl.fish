function fin --description "ggl wrapper for frontend developers"
    argparse --stop-nonopt 'v/version' 'h/help' -- $argv

    set --local version_fin "v0.0.1"
    # color shortcut
    set --local cc (set_color $_ggl_color)
    set --local cn (set_color normal)
    
    set --local param_url
    set --local param_site

    ## also available from ggl command
    set --local url_youtube "https://www.youtube.com/results?search_query="
    set --local url_github "https://github.com/search?q="
    set --local url_stackoverflow "https://stackoverflow.com/search?q="
    set --local url_zenn "https://zenn.dev/search?q="
    set --local url_qiita "https://qiita.com/search?q="

    set --local url_mdn "https://developer.mozilla.org/search?q="
    set --local url_angular "https://angular.io/docs/ts/latest/api/#!?url="
    set --local url_codepen "http://codepen.io/search?q="
    set --local url_npm "https://www.npmjs.com/search?q="

    set --local site_node "nodejs.org"
    set --local site_deno "deno.land"
    set --local site_vue "vuejs.org"
    set --local site_react "reactjs.org"
    set --local site_typescript "typescriptlang.org"
    set --local site_storybook "storybook.js.org"
    set --local site_bem "bem.info"

    if set -lq _flag_version
        functions --query ggl; and \
        eval ggl -v
        echo 'fin.fish:' $version_fin
        return
    else if set -lq _flag_help
        _fin_help
        return
    end 

    if functions --query ggl
        set --local ts (string join "" "$argv")
        if set -q url_$argv[1] && test -n "$ts"
            set param_url url_$argv[1]
            # indirect varibale reference
            # echo $cc "query URL  :" $cn $$param_url
            eval ggl $argv[2..-1] --url=$$param_url
        else if set -q site_$argv[1] && test -n "$ts"
            set param_site site_$argv[1]
            # echo $c "Site name  :" $cn $$param_site
            eval ggl $argv[2..-1] --site=$$param_site
        else if test "$argv[1]" = "ggl" || test "$argv[1]" = "g"
            eval ggl $argv[2..-1] --site=$$param_site
        else if test -n "$ts"
            ggl $argv
        else 
            _fin_help
            return 1
        end
    else
        echo "can't find ggl function"
        return 1
    end
end

## helper function
function _fin_help
    set_color $_ggl_color
    echo 'Usage: '
    echo '      fin [KEYWORDS...] [ggl options]'
    echo '      fin ggl [KEYWORDS...] [ggl options]'
    echo '      fin SUBCOMMAND [KEYWORDS...] [ggl options]'
    echo 'Options: '
    echo '      -v, --version  : Show version info'
    echo '      -h, --help     : Show help'
    echo 'Available subcommands:'
    echo '      ggl, mdn, codepen'
    echo '      youtube github stackoverflow'
    echo '      zenn qiita'
    echo '      npm, node, deno'
    echo '      vue, react, angular'
    echo '      typescript, storybook, bem'
    set_color normal
end

