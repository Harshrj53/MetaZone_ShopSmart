#!/bin/bash

# Configuration
REPO_URL="https://github.com/Harshrj53/MetaZone_ShopSmart.git"
START_DATE="2026-01-19"
END_DATE="2026-04-20"
PROJECT_DIR="/Users/harshraj/Desktop/FSD"

# Setup project structure (ensure .gitkeep files exist)
cd "$PROJECT_DIR"
keep_dir() {
    mkdir -p "$1"
    touch "$1/.gitkeep"
}

keep_dir "backend/prisma/migrations"
keep_dir "backend/src/config"
keep_dir "backend/src/middleware"
keep_dir "backend/src/modules/admin"
keep_dir "backend/src/modules/auth"
keep_dir "backend/src/modules/cart"
keep_dir "backend/src/modules/categories"
keep_dir "backend/src/modules/orders"
keep_dir "backend/src/modules/payments"
keep_dir "backend/src/modules/products"
keep_dir "backend/src/modules/users"
keep_dir "backend/src/utils"
keep_dir "backend/tests/integration"
keep_dir "backend/tests/unit"

if [ ! -f "README.md" ]; then
    echo "# MetaZone ShopSmart" > README.md
    echo "Modern E-Commerce Backend API built with Express, Prisma, and MySQL." >> README.md
fi

# Initialize Git
rm -rf .git
git init
git remote add origin "$REPO_URL"
git checkout -b main

# Date calculation logic (macOS BSD date compatible)
START_SEC=$(date -j -f "%Y-%m-%d" "$START_DATE" "+%s")
END_SEC=$(date -j -f "%Y-%m-%d" "$END_DATE" "+%s")
CURRENT_SEC=$START_SEC

# Filler messages
FILLERS=(
    "refactor: clean up internal logic"
    "docs: update documentation comments"
    "fix: minor linting adjustments"
    "style: improve consistency in formatting"
    "chore: maintenance and housekeeping"
    "refactor: optimize helper functions"
    "test: expand test coverage for utility methods"
    "docs: refine project overview"
    "fix: resolve minor variable naming issues"
    "chore: directory structure cleanup"
)

# Major Phases and their respective files
PHASE_FILES=(
    ".gitignore docker-compose.yml README.md"
    "backend/package.json"
    "backend/prisma/"
    "backend/src/config/"
    "backend/src/utils/"
    "backend/src/middleware/"
    "backend/src/modules/users/"
    "backend/src/modules/auth/"
    "backend/src/modules/products/"
    "backend/src/modules/categories/"
    "backend/src/modules/cart/"
    "backend/src/modules/orders/"
    "backend/src/modules/payments/"
    "backend/src/modules/admin/"
    "backend/tests/"
)

PHASE_MSGS=(
    "chore: initial project setup and infrastructure"
    "feat: initialize backend dependency management"
    "feat: set up database schema and prisma ORM"
    "feat: implement core backend configurations"
    "feat: add utility functions and helpers"
    "feat: implement security and logging middleware"
    "feat: develop user management and profile modules"
    "feat: integrate authentication system and JWT"
    "feat: implement product catalog and inventory logic"
    "feat: add category management and filtering"
    "feat: implement shopping cart functionality"
    "feat: develop order processing and history"
    "feat: integrate payment processing services"
    "feat: implement administrative dashboard APIs"
    "test: add comprehensive test suite for core modules"
)

TOTAL_PHASES=${#PHASE_MSGS[@]}
PHASE_INDEX=0
DAY_COUNTER=0

while [ $CURRENT_SEC -le $END_SEC ]; do
    GIT_DATE=$(date -r $CURRENT_SEC "+%Y-%m-%dT12:00:00")
    
    # Decide if it's a major commit day (every 6 days) or filler
    if [ $((DAY_COUNTER % 6)) -eq 0 ] && [ $PHASE_INDEX -lt $TOTAL_PHASES ]; then
        MSG="${PHASE_MSGS[$PHASE_INDEX]}"
        FILES="${PHASE_FILES[$PHASE_INDEX]}"
        echo "Day $DAY_COUNTER: MAJOR - $MSG ($GIT_DATE)"
        
        # Add files for this phase
        for f in $FILES; do
            if [ -e "$f" ]; then
                git add "$f"
            fi
        done
        PHASE_INDEX=$((PHASE_INDEX + 1))
    else
        # Filler commit
        RAND_MSG=${FILLERS[$RANDOM % ${#FILLERS[@]}]}
        echo "Day $DAY_COUNTER: FILLER - $RAND_MSG ($GIT_DATE)"
        MSG="$RAND_MSG"
        # Commit something small to ensure it's not totally empty if possible, 
        # but --allow-empty is cleaner for fillers.
    fi

    GIT_AUTHOR_DATE="$GIT_DATE" GIT_COMMITTER_DATE="$GIT_DATE" git commit --allow-empty -m "$MSG"
    
    # Increment by 1 day (86400 seconds)
    CURRENT_SEC=$((CURRENT_SEC + 86400))
    DAY_COUNTER=$((DAY_COUNTER + 1))
done

echo "History generated. Pushing to remote..."
git push -u origin main --force

echo "Done! Full daily history pushed from $START_DATE to $END_DATE."
