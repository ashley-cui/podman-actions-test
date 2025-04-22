ref=v10.8.7-rc4
version=${ref#v}
branch="${version%.*}"
echo $version
echo $branch
if [[ $version == *-rc* ]]; then
    echo "is a rc - bumping z down to dev"
    devbump="${version%-*}-dev"
else
    echo "bumping z up to dev"
    arr=($(echo "$version" | tr . '\n'))
    arr[2]=$((${arr[2]}+1))
    devbump="$(IFS=. ; echo "${arr[*]}")-dev"

    asdf="$(IFS=. ; echo "${arr[*]}")-dev"
fi

echo $devbump

echo

# sed -i "s/const RawVersion = ".*"/const RawVersion = "${devbump}"/g" version/rawversion/version.go
