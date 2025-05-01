# ref=v10.8.7-rc4
# version=${ref#v}
# branch="${version%.*}"
# echo $version
# echo $branch
# if [[ $version == *-rc* ]]; then
#     echo "is a rc - bumping z down to dev"
#     devbump="${version%-*}-dev"
# else
#     echo "bumping z up to dev"
#     arr=($(echo "$version" | tr . '\n'))
#     arr[2]=$((${arr[2]}+1))
#     devbump="$(IFS=. ; echo "${arr[*]}")-dev"

#     asdf="$(IFS=. ; echo "${arr[*]}")-dev"
# fi

# echo $devbump

# echo

# sed -i "s/const RawVersion = ".*"/const RawVersion = "${devbump}"/g" version/rawversion/version.go
# prevversion=`grep -P "(?<=export const LATEST_VERSION = ')(\d.\d.\d)" -o static/data/global.ts`

mainvers=`grep -P '(?<=const RawVersion = ")(\d.\d)' -o version/rawversion/version.go`
ref=v6.7.7-rc1
releasevers=${ref#v}
echo $releasevers

if echo "${mainvers},${releasevers}" | tr ',' '\n' | sort -V -C
then
    echo "bump=true" >> $GITHUB_OUTPUT
    echo "Main is lower than release, so we need to bump main"

else
    echo "SKIPPING: Main is higher than release, no need to bump"
fi

rel=($(echo "$releasevers" | tr . '\n'))
rel[1]=$((${rel[1]}+1))
rel[2]=0
devbump="$(IFS=. ; echo "${rel[*]}")-dev"
echo $devbump

sed -i "s/const RawVersion = \".*\"/const RawVersion = \"$devbump\"/g" version/rawversion/version.go
