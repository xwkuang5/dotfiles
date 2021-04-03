function merge_gitignore_files
    rm -f .gitignore
    echo "Merging .gitignore files..."
    for file in (ls -a | grep "\..*\.gitignore")
        cat $file >> .gitignore
    end
    echo "Done!"
end
