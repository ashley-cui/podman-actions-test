ref=v5.5.0-dev
# version=${ref#v}
# if [[ $version == *-rc* ]]; then
#     echo "is a rc - bumping z down to dev"
#     devbump="${version%-*}-dev"
# else
#     echo "bumping z up to dev"
#     arr=($(echo "$version" | tr . '\n'))
#     arr[2]=$((${arr[2]}+1))
#     devbump="$(IFS=. ; echo "${arr[*]}")-dev"
# fi

version=${ref#v}
eggs=${ref#v%.*}
echo $eggs
# echo $devbump